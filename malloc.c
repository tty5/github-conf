#include <stdio.h>                                                                                                                                                                                           [0/169]
#include <dlfcn.h>
#include <string.h>
#include <malloc.h>

typedef void* (*malloc_t)(size_t) ;
typedef void (*free_t)(void*) ;

char array[1 << 20];
void* parray = &array[0];

static void* libc = NULL;
malloc_t libc_malloc = NULL;
free_t libc_free = NULL;

void free(void* p)
{
        if ( p >= (void*)&array[0] && p < (void*)(&array[0] + sizeof(array)) ){
                return;
        }else if (libc_free != NULL){
                libc_free(p);
        }
}
void* malloc(size_t size)
{
        if (libc_malloc == NULL){
                void* ret = parray;
                parray += size;
                return ret;
        }

        void *p = libc_malloc(size);

        printf("malloc: p = %p, size = %lu\n", p, size);
        return p;
}
void malloc_init(void)
{
        libc = dlopen("/lib/x86_64-linux-gnu/libc-2.15.so", RTLD_LAZY);
        if (libc == NULL){
                printf("open libc failed\n");
                return ;
        }

        libc_malloc = dlsym(libc, "malloc");
        if (libc_malloc == NULL){
                printf("get malloc address failed\n");
                return ;
        }

        libc_free = dlsym(libc, "free");
        if (libc_free == NULL){
                printf("get free address failed\n");
        }
}
void __attribute__ ((constructor)) malloc_init(void);
