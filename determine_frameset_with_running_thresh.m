function [pb_frame_set] = determine_frameset_with_running_thresh(siteID,running_threshold,percent_threshold)
tp = 1;
proj_meta = evalin('base','proj_meta');
expLog = evalin('base','expLog');
expID =  proj_meta(siteID).ExpGroup;
index = find([expLog.expid{:}] == expID);
current_comments = expLog.comment(index);
current_comments = extractBefore(current_comments,3); %restricts to first two letters
frame_set_indices = find(contains(current_comments,'pb','IgnoreCase',true));
current_frames = proj_meta(siteID).rd(tp).nbr_frames;
first_frame = 1;
frame_sets ={};
for iter = 1:length(current_frames)
    final_frame = first_frame + current_frames(iter);
    current_frame_set = [first_frame:final_frame];
    first_frame = first_frame + current_frames(iter);
    frame_sets{iter} = current_frame_set;
end
pb_frame_set = [];
for index = frame_set_indices
    pb_frame_set = [pb_frame_set,frame_sets{index}];
end
running = proj_meta(siteID).rd(1,tp).velM;
running = max(running,0);
if siteID > 19 && siteID < 31
    running = running * 10;
end
first_session = pb_frame_set(1:7500);
second_session = pb_frame_set(7501:end);
final_frame_set = [];
running_percent_1st = sum(running(first_session)>running_threshold)/length(running(first_session));
running_percent_2nd = sum(running(second_session)>running_threshold)/length(running(second_session));
if running_percent_1st > percent_threshold
    final_frame_set = [final_frame_set,first_session];
end
if running_percent_2nd > percent_threshold
    final_frame_set = [final_frame_set,second_session];
end
if isempty(final_frame_set)
    disp 'remove the following site:'
    siteID
end
end

