#!/usr/bin/env bash

# 12-factor config, using environment variables for dynamic values

# PredictionIO Main Configuration
#
# This section controls core behavior of PredictionIO. It is very likely that
# you need to change these to fit your site.

# SPARK_HOME: Apache Spark is a hard dependency and must be configured.
# Must match $spark_dist_dir in bin.compile
SPARK_HOME=/app/pio-engine/PredictionIO-dist/vendors/spark-hadoop
SPARK_LOCAL_IP="${HEROKU_PRIVATE_IP:-}"
SPARK_PUBLIC_DNS="${HEROKU_DNS_DYNO_NAME:-}"

# ENGINE_CONF_DIR: to set the configuration directory of the engine
ENGINE_CONF_DIR=$BUILD_DIR/engine-conf

echo "******************************************************"
echo "** BUILD_DIR: $BUILD_DIR**"
ls -la $BUILD_DIR
echo "** ENGINE_CONF_DIR: $ENGINE_CONF_DIR"
echo "******************************************************"

PIO_FS_BASEDIR=$HOME/.pio_store
PIO_FS_ENGINESDIR=$PIO_FS_BASEDIR/engines
PIO_FS_TMPDIR=$PIO_FS_BASEDIR/tmp
