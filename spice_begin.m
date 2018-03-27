%% Loads spice environment
global logger
logger = log4m.getLogger();

warning('off','MATLAB:dispatcher:nameConflict');
%warning('off','all');

logger.setLogLevel(logger.ERROR);
logger.setCommandWindowLevel(logger.ERROR);