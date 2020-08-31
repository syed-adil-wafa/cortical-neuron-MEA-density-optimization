%% Optimizing seeding density of patient-derived excitatory glutamatergic NGN2 cortical neurons for multi-electrode array recordings

close all % close all figures
clear % clear workspace
clc % clear command window
rng(1); % seed random number generator for reproducibility

%% Multi-electrode array configuration

% Define the # of wells in multi-electrode array plate
mea_config.number_of_wells = 48;

% Define the # of experimental conditions (e.g. seeding density, cell lines)
mea_config.number_of_conditions = 3;

% Define the electrophysiological feature start and end rows in data files
mea_config.start_row = 115;
mea_config.end_row = 157;

% Filter out wells with 0 active electrodes
% 0: select all wells, 1: select wells with 1 or more active electrodes
mea_config.active_elecs_filter = 1;

%% Seeding density information

% Change directory to enable helper functions
cd helper-functions

% Define wells for each experimental condition
mea_config.plate = mea_plate(mea_config.number_of_wells);
mea_config.wells_condition_1 = [mea_config.plate.A(1:8) mea_config.plate.B(1:8)];
mea_config.wells_condition_2 = [mea_config.plate.C(1:8) mea_config.plate.D(1:8)];
mea_config.wells_condition_3 = [mea_config.plate.E(1:8) mea_config.plate.F(1:8)];

% Define labels for each experimental condition
mea_config.labels_condition_1 = '100k';
mea_config.labels_condition_2 = '150k';
mea_config.labels_condition_3 = '200k';

% Concatenate wells of all experimental conditions
if mea_config.number_of_conditions == 1
    processing.conditions = mea_config.wells_condition_1;
else
    processing.conditions = catpad(1,...
        mea_config.wells_condition_1,...
        mea_config.wells_condition_2,...
        mea_config.wells_condition_3);
end

% Concatenate labels of all experimental conditions
if mea_config.number_of_conditions == 1
    processing.labels = {mea_config.labels_condition_1};
else
    processing.labels = {...
        mea_config.labels_condition_1,...
        mea_config.labels_condition_2,...
        mea_config.labels_condition_3};
end

%% Data extraction

% Change directory to extract data
cd ../data

% Suppress warnings associated with data extraction
w = warning('on', 'all');
id = w.identifier;
warning('off', id);

% Retrieve all .csv files in the data folder
extraction.files = dir('*.csv');

% Extract data from each file
for file = 1:size(extraction.files, 1)
    
    % Get the name of each individual file and store them in one vector
    extraction.current_file = extraction.files(file).name;
    extraction.filenames(:, file) = cellstr(extraction.current_file);
    
    % Read data from each file
    extraction.file_data = readcell(...
        [pwd, (append('/', extraction.current_file))]);
    extraction.raw_data(:, :, file) = cell2mat(table2cell(cell2table(...
        extraction.file_data(mea_config.start_row:mea_config.end_row,...
        2:mea_config.number_of_wells + 1))));
    
    % Get labels for each electrophysiological feature
    extraction.feature_labels = readcell(...
        [pwd, (append('/', extraction.current_file))]);
    extraction.feature_labels = extraction.feature_labels(...
        mea_config.start_row:mea_config.end_row, 1);
    
end

% Extract time-points from file names
extraction.time = regexprep(extraction.filenames, '[D.csv]', '');

% Modify feature labels
extraction.feature_labels = strrep(extraction.feature_labels, "Number", "#");

% Change directory back to enable helper functions
cd ../helper-functions

%% Data processing

% Sort time-points in ascending order
[extraction.time, extraction.timeorder_index] = sort(...
    str2double(extraction.time), 'ascend');

% Set the starting time-point as day 1
if extraction.time(:, 1) ~= 1
    extraction.time(1, 2:size(extraction.time, 2) + 1) = extraction.time;
    extraction.time(1, 1) = 1;
end

% Sort extracted data by time
processing.raw_data = extraction.raw_data(:, :, extraction.timeorder_index);

% Reshape data as well x feature x time
processing.raw_data = permute(processing.raw_data, [2, 1, 3]);

% Impute NaN values as 0
processing.raw_data(isnan(processing.raw_data)) = 0;

% Set day 1 values as 0
processing.processed_data(:, :, 2:size(processing.raw_data, 3) + 1) =...
    processing.raw_data;
processing.processed_data(:, :, 1) = 0;

% Perform linear interpolation to create an evenly spaced time vector
processing.time = 1:extraction.time(1, end);

% Perform linear interpolation to create an evenly spaced data matrix
for feature = 1:size(processing.processed_data, 2)
    
    for well = 1:size(processing.processed_data, 1)
        
        processing.interpolated_well = permute(interp1(...
            extraction.time,...
            permute(processing.processed_data(well, feature, :), [1, 3, 2]),...
            processing.time),...
            [1, 3, 2]);
        
        processing.interpolated_matrix(well, feature, :) = ...
            processing.interpolated_well;
        
    end
    
end

%% Data analysis

% For each condition, calculate the mean and standard error of the mean
% (SEM) for each feature for each time-point
for condition = 1:mea_config.number_of_conditions
    
    for feature = 1:size(processing.interpolated_matrix, 2)
        
        analysis.cell_line = processing.conditions(condition, :);
        
        % Index the first column that has a NaN value
        analysis.nan_column = [];
        for wells = 1:size(analysis.cell_line, 2)
            if double(isnan(analysis.cell_line(:, wells))) == 1
                analysis.nan_column = [analysis.nan_column; wells];
                break
            end
        end
        
        % If a NaN value is present, select all columns, otherwise select
        % 1:(n-1) columns
        if size(analysis.nan_column, 1) == 0
            analysis.selected_wells = ...
                processing.interpolated_matrix(analysis.cell_line, :, :);
        else
            analysis.selected_wells = processing.interpolated_matrix(...
                processing.conditions(condition, ...
                1:(analysis.nan_column - 1)), :, :);
        end
        
        % If wells with 1+ active electrodes is selected, filter out
        % wells with no activity; # of active electrodes if feature #4
        analysis.inactive_wells = [];
        if mea_config.active_elecs_filter == 1
            for wells = 1:size(analysis.selected_wells, 1)
                if analysis.selected_wells(...
                        wells, 4, size(analysis.selected_wells, 3)) == 0
                    analysis.inactive_wells = ...
                        [analysis.inactive_wells; wells];
                end
            end
            analysis.selected_wells(analysis.inactive_wells, :, :) = [];
        end
        
        % Impute NaN values as 0
        analysis.selected_wells(isnan(analysis.selected_wells)) = 0;
        
        % Re-shape matrix for computing statistical metrics
        analysis.selected_wells = ...
            analysis.selected_wells(:, feature, :);
        analysis.selected_wells = reshape(analysis.selected_wells,...
            [size(analysis.selected_wells, 1),...
            size(analysis.selected_wells, 3)]);
        
        % Compute mean and standard error of the mean (SEM) for each
        % time-point
        analysis.condition_mean(condition, feature, processing.time) =...
            permute(nanmean(analysis.selected_wells), [1 3 2]); % mean
        analysis.condition_sem(condition, feature, processing.time) =...
            permute(nanstd(analysis.selected_wells) ./...
            (sqrt(size(analysis.selected_wells, 1) - 1)), [1 3 2]); % SEM
        
    end
    
end

%% Data visualization

plots.firing = 1:5; % firing indices
plots.bursting = 6:24; % bursting indices
plots.nbursting = 25:37; % network bursting indices
plots.synchrony = 38:43; % synchrony indices


for fig = 1:4
    
    % Define the features to be plotted and the figure dimensions
    if fig == 1
        plots.plot_feature = plots.firing'; % plot firing features
        rows = 2; cols = 3;
        title = 'Firing at different cell densities';
    elseif fig == 2
        plots.plot_feature = plots.bursting'; % plot bursting features
        rows = 4; cols = 5;
        title = 'Bursting at different cell densities';
    elseif fig == 3
        plots.plot_feature = plots.nbursting'; % plot network bursting features
        rows = 4; cols = 4;
        title = 'Network bursting at different cell densities';
    elseif fig == 4
        plots.plot_feature = plots.synchrony'; % plot synchrony features
        rows = 2; cols = 3;
        title = 'Synchrony at different cell densities';
    end
    
    
    figure; hold on; box off
    suptitle(title); % figure title
    
    for feature = 1:size(plots.plot_feature, 1)
        
        % Configure figure settings
        subplot(rows, cols, feature);
        hold on; box on
        axis tight % set axis limits to equal the range of the data
        set(gca, 'TickDir', 'in'); % set tick direction outwards
        set(gca, 'XTick', 1:3:size(processing.time, 2)); % set x-ticks
        
        for condition = 1:mea_config.number_of_conditions
            
            % Retrieve mean and SEM of each feature separately
            plots.condition_mean = permute(...
                analysis.condition_mean(condition, plots.plot_feature(feature, :), :),...
                [1 3 2]);
            plots.condition_sem = permute(...
                analysis.condition_sem(condition, plots.plot_feature(feature, :), :),...
                [1 3 2]);
            
            % Plot mean and SEM for each feature for each condition
            plots.fig(condition) = errorbar(...
                processing.time(:, extraction.time),...
                plots.condition_mean(:, extraction.time),...
                plots.condition_sem(:, extraction.time),...
                'LineWidth', 2);
            
            % Set legend settings
            plots.condition = processing.conditions(condition, :);
            plots.legend_info{condition} = ...
                [processing.labels{:, condition} ' (n=' num2str(...
                length(plots.condition(~isnan(plots.condition)))) ')'];
            legend(plots.legend_info, 'location', 'northwest');
            
        end
        
        % Set X- and y-axis labels
        xlabel('Time (days after re-plating)');
        ylabel(cellstr(...
            extraction.feature_labels(plots.plot_feature(feature, :), :)));
    end
    
end

%% End of script

% Remove unneeded variables from workspace
remove_variables = {...
    'cols',...
    'condition',...
    'feature',...
    'fig',...
    'file',...
    'id',...
    'rows',...
    'time',...
    'w',...
    'well',...
    'wells',...
    };
clear(remove_variables{1, :})
clear 'remove_variables'