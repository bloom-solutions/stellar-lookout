# README

[![Build Status](https://travis-ci.org/imacchiato/stellar_lookout.svg?branch=master)](https://travis-ci.org/imacchiato/stellar_lookout)

Almost all actions in the app run in jobs. Almost all jobs are triggered by a schedue, or by other jobs, to make work more atomic.

Documentation is still under development. See `app/controllers/api/v1/wards_controller.rb`.

## Docker

To get this running on Docker, you need to set the environment variables you see in `.env.production`.

Images are available in [Docker Hub](https://hub.docker.com/r/bloomsolutions/stellar_lookout).
