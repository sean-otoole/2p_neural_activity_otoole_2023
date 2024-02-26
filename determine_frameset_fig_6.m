function [final_frame_set] = determine_frameset_fig_6(siteID,session_type)
tp = 1;
proj_meta = evalin('base','proj_meta');
expLog = evalin('base','expLog');
expID =  proj_meta(siteID).ExpGroup;
index = find([expLog.expid{:}] == expID);
current_comments = expLog.comment(index);
current_comments = extractBefore(current_comments,3); %restricts to first two letters
frame_set_indices = find(contains(current_comments,session_type,'IgnoreCase',true));
current_frames = proj_meta(siteID).rd(tp).nbr_frames;
first_frame = 1;
frame_sets ={};
if strcmp(session_type,'all')
    if siteID < 30
        final_frame_set = 1:(length(proj_meta(siteID).rd(tp).velM));
    else
        final_frame_set = [1:12500];
    end
else
    for iter = 1:length(current_frames)
        final_frame = first_frame + current_frames(iter);
        current_frame_set = [first_frame:final_frame];
        first_frame = first_frame + current_frames(iter);
        frame_sets{iter} = current_frame_set;
    end
    final_frame_set = [];
    for index = frame_set_indices
        final_frame_set = [final_frame_set,frame_sets{index}];
    end
end
end