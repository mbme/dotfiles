#!/usr/bin/env bash

pkill -9 gammastep || true

sleep 1

gammastep -l 49.842957:24.031111
