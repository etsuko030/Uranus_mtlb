function t = fetchPath()

% Fetch two paths through ui (return as 1x2 cell array)

% Default path
start_path = fullfile(matlabroot, '\toolbox\images\imdemos');

import = uigetdir(start_path);
if import == 0
	return;
end

export = uigetdir(start_path);
if export == 0
	return;
end

t = {import, export};

%disp(import);
%disp(export);
end