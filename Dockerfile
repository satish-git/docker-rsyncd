FROM ubuntu:16.04
MAINTAINER https://github.com/muccg/docker-rsyncd

RUN env | sort

RUN apt-get update && apt-get install -y --no-install-recommends \
  rsync \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN addgroup --gid 1000 ccg-user \
  && adduser --disabled-password --home /data --no-create-home --system -q --uid 1000 --ingroup ccg-user ccg-user \
  && mkdir /data \
  && chown ccg-user:ccg-user /data

EXPOSE 873

# Drop privileges, set home for ccg-user
USER ccg-user
ENV HOME /data
WORKDIR /data

# entrypoint shell script that by default starts uwsgi
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["rsyncd"]