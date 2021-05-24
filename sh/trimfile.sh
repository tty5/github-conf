trimfile() {
    sed -i 's/[ ]*$//' "$1"
}

trimfile "$1"
