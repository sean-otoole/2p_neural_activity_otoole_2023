function chans=load_ach_chans(fname)
%loads the channel names of an ach file and returns them as a cell array

fi=fopen(fname,'r');
txt=fscanf(fi,'%c');
fclose(fi);
txt=strsplit(txt,'\n');

ch_ind=0;
chans={};

for ind=2:numel(txt) % skip header-line
    
    search_str=['auxrec.channel' num2str(ch_ind) ' '];

    if strcmp(txt{ind}(1:length(search_str)),search_str)
        subchunk = regexp(txt{ind}, '(?<=")[^"]+(?=")', 'match');
        ch_ind=ch_ind+1;
        search_str=['auxrec.channel' num2str(ch_ind) ' '];
        chans{ch_ind}=subchunk{1};
    end
end


