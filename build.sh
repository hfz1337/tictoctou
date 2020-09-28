#!/bin/bash
docker build --tag=pwn/tictoctou .
docker run -d -p 2222:22 --rm --name=tictoctou -it pwn/tictoctou
