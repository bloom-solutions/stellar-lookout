# README

[![Build Status](https://travis-ci.org/bloom-solutions/stellar-lookout.svg?branch=master)](https://travis-ci.org/bloom-solutions/stellar-lookout)

Almost all actions in the app run in jobs. Almost all jobs are triggered by a schedue, or by other jobs, to make work more atomic.

Documentation is still under development. See `app/controllers/api/v1/wards_controller.rb`.

## Usage

StellarLookout must be told at least once to watch a Stellar address. This is done by creating a ward (see `spec/requests/api/v1/wards_spec.rb`). All addresses that are watched are published in the `/events` MessageBus channel, *and* in the `/events-G-THIS-IS-THE-STELLAR-ADDRESS` channel (if you just care about a specific address).

## Docker

To get this running on Docker, you need to set the environment variables you see in `.env.production`.

Images are available in [Docker Hub](https://hub.docker.com/r/bloomsolutions/stellar_lookout).

## Configuration

If you do not want to sync backwards in time (like in development), then set the `BACKWARD_SYNC_LEDGERS=false` in the env.

## Development

```sh
docker-compose up db
cp config/database.yml{.sample,}
bundle exec rake db:create db:migrate db:test:prepare
```
