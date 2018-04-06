#!/bin/env python
# File: /usr/share/gdb/python/gdb/command/dig.py
#
"""
GDB commands to show internals of data structure.

(gdb) dig mutex
                         Offset Bits Type                             Name

    struct mutex {
    | atomic_t {
    | |                  0x0    32   int                              counter;
    | } count;
    | spinlock_t {
    | | union {...} {
    | | | struct raw_spinlock {
    | | | | arch_spinlock_t {
    | | | | | atomic_t {
    | | | | | |          0x4    32   int                              counter;
    | | | | | } val;
    | | | | } raw_lock;
    | | | } rlock;
    | | } ;
    | } wait_lock;
    | struct list_head {
    | |                  0x8    64   struct list_head *               next;
    | |                  0x10   64   struct list_head *               prev;
    | } wait_list;
    |                    0x18   64   struct task_struct *             owner;
    | struct optimistic_spin_queue {
    | | atomic_t {
    | | |                0x20   32   int                              counter;
    | | } tail;
    | } osq;
    } ;
"""
import gdb
import exceptions
headPrinted = False
MAX_NEST_LEVEL = 8

class Dig(gdb.Command):
    def __init__(self):
        super (Dig, self).__init__ ('dig', gdb.COMMAND_DATA)

    def dumpStruct(self, stype, level, offset, name):
        global headPrinted
        if not headPrinted:
           print "%24s %-6s %-4s %-32s %-32s\n" \
                   %("","Offset", "Bits", "Type", "Name")
           headPrinted = True

        # avoid stack overflow or row be too long
        if level > MAX_NEST_LEVEL:
            return

        shift = ""
        for i in range(level):
            shift += " |"

        body_prefix = '    |' + shift
        head_prefix = '   ' + shift
        tail_prefix = '   ' + shift
        print "%-24s" %(head_prefix + " " + str(stype) + " {")
        try:
            for field in stype.fields():
                real_type = field.type.strip_typedefs()
                if real_type.code == gdb.TYPE_CODE_UNION or \
                        real_type.code == gdb.TYPE_CODE_STRUCT or \
                        real_type.code == gdb.TYPE_CODE_TYPEDEF :
                    self.dumpStruct(field.type,
                                    level + 1,
                                    field.bitpos / 8 + offset,
                                    field.name if field.name else "")
                else:
                    print "%-24s 0x%-4x %-4d %-32s %-32s" \
                            %(body_prefix, \
                            field.bitpos / 8 + offset, \
                            field.bitsize if field.bitsize else field.type.sizeof * 8, \
                            field.type, \
                            field.name +';')
        except exceptions.TypeError as e:
            print e
            print stype
        print "%-24s" %(tail_prefix + " } " + name + ";")

    def invoke(self, arg, from_tty):
        try:
            stype = gdb.lookup_type('struct %s' % arg)
        except:
            try:
                stype = gdb.lookup_type(arg)
            except:
                print "type <%s> not found!" % (arg)
                return

        self.dumpStruct(stype, 0, 0, "")

Dig()

