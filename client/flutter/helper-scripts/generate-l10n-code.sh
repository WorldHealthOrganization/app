#!/bin/sh
flutter pub run intl_utils:generate
flutter format lib/generated/**
