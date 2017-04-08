#!/usr/bin/env bash
cpplint --root=include --linelength=120 --filter=-legal,-build/c++11 "$@"
