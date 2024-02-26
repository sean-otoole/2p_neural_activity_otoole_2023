function ExpLog=getExpLog(varargin)
%Functions extracts all entries in the ExpLog database.
%
%Output of this function is a cell array with:
%       stackid
%       expid
%       comment
%       siteid
%       analysiscode
%       animalid
%       project
%       location
%       pi
%
%
%documented by DM - 08.05.2014

p=inputParser;
addParameter(p,'suppressWarning',0,@(x) isnumeric(x) || islogical(x))
addParameter(p,'forceRefresh',0,@(x) isnumeric(x) || islogical(x))
addParameter(p,'extended',0,@(x) isnumeric(x) || islogical(x))
parse(p,varargin{:})


if ~evalin('base','exist(''ExpLog'',''var'')')  || p.Results.forceRefresh
    try
        DB=connectToExpLog; 
        if(p.Results.extended==true)
            sql = ['SELECT Stacks.stackid, Stacks.expid, Stacks.comment, Stacks.stackdate, Stacks.StackTime, Experiments.siteid, Experiments.analysiscode, '...
                'Sites.animalid, Sites.project, Sites.location,Sites.depth, Animals.pi, Animals.gender, Animals.DoB, Animals.DoD, Animals.strain, Animals.VivariumID FROM Stacks INNER JOIN Experiments ON Stacks.expid=Experiments.expid '...
                'INNER JOIN Sites ON Experiments.siteid=Sites.siteid INNER JOIN Animals ON Sites.AnimalID=Animals.AnimalID ORDER BY Stacks.stackid'];
        else
            sql = ['SELECT Stacks.stackid, Stacks.expid, Stacks.comment, Stacks.stackdate, Stacks.DataDeleted, Experiments.siteid, Experiments.analysiscode, '...
                'Sites.animalid, Sites.project, Sites.location, Animals.pi, Animals.strain FROM Stacks INNER JOIN Experiments ON Stacks.expid=Experiments.expid '...
                'INNER JOIN Sites ON Experiments.siteid=Sites.siteid INNER JOIN Animals ON Sites.AnimalID=Animals.AnimalID ORDER BY Stacks.stackid'];
        end
        ExpLog = adodb_query(DB, sql);
        %replace non-strings (Nans) in comment field with empty string
        ExpLog.comment(~cellfun(@ischar,ExpLog.comment))={''};
        %same for acode
        ExpLog.analysiscode(~cellfun(@ischar,ExpLog.analysiscode))={''};
     
        DB.release;
        
    catch me
        %if ExpLog cannot connect, search in current directory for offline %copy...
        if exist('ExpLog.mat','file')
            fprintf('ATTENTION: Couldn''t connect to ExpLog database. Loading save-file from current directory.\n')
            fprintf('\nError message:%s\n%s\n',me.identifier,me.message)
            fprintf('loading file...')
            load('ExpLog.mat');
            assignin('base','ExpLog',ExpLog);
            fprintf('done.\n')
        end
    end
else
    ExpLog=evalin('base','ExpLog');
    fieldnames_ExpLog = fieldnames(ExpLog)';
    
    if p.Results.extended~=0 && ~ismember('dob',fieldnames_ExpLog)
        ExpLog=getExpLog(varargin{:},'forceRefresh',1); 
        return;
    end
    
    %if ExpLog contains field 'ExpLog.suppresswarning' - do not throw an error
    idx = ~cellfun(@isempty,regexpi(fieldnames_ExpLog,'suppresswarning'));
    if any(idx) || p.Results.suppressWarning 
        ExpLog=rmfield(ExpLog,fieldnames_ExpLog(idx));
    else
        disp('NC Warning - getting ExpLog from ''base'' workspace!')
    end
    
end