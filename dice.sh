#!/bin/bash

usage() {
    echo "dice.sh - a tool to select random words from a source, to generate a strong passphrase"
    echo ""
    echo "Usage:"
    echo "dice.sh /path/to/source/text"
}

main() {
    source=$1
    select_count=$2

    if [ -z "$source" ] || [ "$source" == "-h" ] || [ "$source" == "--help" ]; then
        usage
        exit 1
    fi

    wordcount=$(cat $source | tr -cs A-Za-z '\n' | tr A-Z a-z | sort | uniq | wc -l)

    if [ $wordcount -lt 7776 ]; then
        echo "Warning: provided source does not contain a sufficient number of unique words to ensure a strong pass phrase"
    fi

    echo "Using source $source with a word count of $wordcount"
    echo "Selecting 6 random words:"
    echo "-------------------------"

    cat $source | tr -cs A-Za-z '\n' | tr A-Z a-z | sort | uniq | shuf --random-source=/dev/random -n6
}
main $@
