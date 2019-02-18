#!/bin/bash

failed=0
for exercise_directory in $(find ./exercises/* -type d); do
    tmpdir=$(mktemp -d)
    test_file=$(find "$exercise_directory" -type f -name '*.tests.ps1')
    solution_file=$(find "$exercise_directory" -type f -name '*.example.ps1')
    cp $(printf "%s" "$test_file") "$tmpdir"
    cp $(printf "%s" "$solution_file") "$tmpdir/$(basename "${test_file//.tests}")"
    results="$(pwsh -WorkingDirectory "$tmpdir" -Command 'Invoke-Pester' | tee /dev/tty)"
    rm -rf "$tmpdir"
    failures="$(grep -oP '(?<=Failed: )[[:digit:]]+' <<< "$results")"
    if [ "$failures" -ne '0' ]; then
        # echo "$(basename "$exercise_directory"): $failures failed tests."
        # exit 1
        failed="$(( failed + 1 ))"
    fi
done

echo "$failed failed exercises."
exit "$failed"
