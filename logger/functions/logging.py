import os
import time
import logging
from systemd import journal

loggers = {}

def myLogger(name):
    global loggers

    if loggers.get(name):
        return loggers.get(name)
    else:
        logger = logging.getLogger(name)
        logger.setLevel(logging.DEBUG)
        handler = journal.JournaldLogHandler()
        logger.addHandler(handler)
        loggers[name] = logger

        return logger