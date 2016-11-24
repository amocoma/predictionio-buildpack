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

if [ -z "$ENGINE_CONF_DIR" ]; then
  export PIO_ENV_LOADED=1
else
  cat ${ENGINE_CONF_DIR}/pio-engine-env.sh
  if [ -f "${ENGINE_CONF_DIR}/pio-engine-env.sh" ]; then
    # Promote all variable declarations to environment (exported) variables
    set -a
    . "${ENGINE_CONF_DIR}/pio-engine-env.sh"
    set +a
  else
    echo -e "\033[0;35mWarning: pio-engine-env.sh was not found in ${ENGINE_CONF_DIR}. Using system environment variables instead.\033[0m\n"
  fi
fi
