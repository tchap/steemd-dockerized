# steemd-dockerized

Run steemd in Docker, efficiently.

## About

There is already [steemd-docker](https://github.com/blood2/steemd-docker),
so why another Docker image for `steemd`?

There is one major issue with the approached being used there. When using Docker Machine,
mounting a local directory as a volume degrades performance significantly. That's why
the image presented in this repository uses a different way - a data volume container.

## How to Hold It Right

Let's see how to make the whole thing work.

## The Data Container

1. Create - `docker create -v /steemdata --name steemdata ubuntu:16.04 /bin/true`

## The Steemd Container

In you are using Docker Machine, use `HOST` set to `0.0.0.0`,
otherwise you can use `127.0.0.0` just fine.

1. Build - `docker build -t steemd:dockerized .` There is a bunch of arguments available,
   please check `Dockerfile` for what is possible to overwrite.
2. Configure - Copy `config.ini.example` to `config.ini` and modify as needed.
2. Run - `docker run -d -p $HOST:8090:8090 --volumes-from steemdata --name steemd steemd:dockerized`
3. You can see what is happening now by running `docker logs -f steemd`.

## Upvote

Feel free to [upvote](https://steemit.com/steemd-docker/@void/dockerfile-for-steemd-tuned-for-performance)
the effort on Steemit.
