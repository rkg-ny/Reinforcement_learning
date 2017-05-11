function r =  rl()
lr = 0.07;
real_itr = [];
%state = 30:255
%action = -300:300
dist_vec = [];
rssi_vec = [];
rssi_vec_det=[];
itr_vec = [];
itr =400;
lr_vec = [];
avg_des = 68;
step_len = 0;
%k = 1;
r_var = randi([30 200])
orig_dist = r_var;
rssi_new = 0;
%rssi_det = 0;
rssi_intmd_new = 0;
%rssi_intmd_old = 0;
%reward = 0;
mf_name_to_update = '';
flag = 1;
%flag_steplen = 0;
%intmd_dist = 0;
mf_num = 0;
%flg = 0;
%flg_steplen = 0;
%orig_dist =  get_original_distance(orig_dist,step_len);%make original distance random
orig_dist =  get_original_distance(orig_dist)
%orig_dist =  get_original_distance();
cntr = 0;
rl_cnt = 0;
%rssi_new = get_rssi_at_dist()
	persistent vec_vs1;persistent vec_vs2;persistent vec_vs3;persistent vec_vs4;persistent itr_vec_vs;
    persistent cnt_vs;persistent vec_s1;persistent vec_s2;persistent vec_s3;persistent vec_s4;
    persistent itr_vec_s;persistent cnt_s;persistent vec_d1;persistent vec_d2;persistent vec_d3;
    persistent vec_d4;persistent itr_vec_d;persistent cnt_d ;persistent vec_w1 ;persistent vec_w2;
    persistent vec_w3;persistent vec_w4;persistent itr_vec_w;persistent cnt_w ;persistent vec_l1;
    persistent vec_l2;persistent vec_l3 ;persistent vec_l4;persistent itr_vec_l;persistent cnt_l;
	persistent sl_vs;persistent itr_vec_sl_vs;persistent cnt_sl_vs;persistent sl_s;persistent itr_vec_sl_s;
    persistent cnt_sl_s;persistent sl_d;persistent itr_vec_sl_d;persistent cnt_sl_d;persistent sl_w ;
    persistent itr_vec_sl_w;persistent cnt_sl_w;persistent sl_l;persistent itr_vec_sl_l;persistent cnt_sl_l;
	vec_vs1 =[];vec_vs2 =[]; vec_vs3 =[]; vec_vs4 =[]; itr_vec_vs =[]; cnt_vs = int16(0); vec_s1 =[]; vec_s2 =[];
    vec_s3 =[]; vec_s4 =[]; itr_vec_s =[]; cnt_s = int16(0); vec_d1 = []; vec_d2 = []; vec_d3 = []; vec_d4 = []; 
    itr_vec_d =[]; cnt_d = int16(0); vec_w1 = []; vec_w2 = []; vec_w3 = []; vec_w4 = []; itr_vec_w =[];
    cnt_w = int16(0); vec_l1 = []; vec_l2 = []; vec_l3 = []; vec_l4 = []; itr_vec_l =[]; cnt_l = int16(0);
    sl_vs = []; itr_vec_sl_vs =[]; cnt_sl_vs = int16(0); sl_s = []; itr_vec_sl_s =[]; cnt_sl_s = int16(0); 
    sl_d = []; itr_vec_sl_d =[]; cnt_sl_d = int16(0); sl_w = []; itr_vec_sl_w =[]; cnt_sl_w = int16(0);
    sl_l = []; itr_vec_sl_l =[]; cnt_sl_l = int16(0);
	
for k = 1:itr
    cntr = cntr + 1
    real_itr = [real_itr cntr];
    %itr_vec = [itr_vec k]
    if (flag == 1)
    %rssi_new = get_rssi_at_dist(orig_dist);
    rssi_new = get_rssi_at_dist()
    end
    mf_name_to_update = get_mf_name_to_update()
    %mf_num = get_updated_parameters_mf(vec_vs1,vec_vs2,vec_vs3,vec_vs4,itr_vec_vs,cnt_vs,vec_s1,vec_s2,vec_s3,vec_s4,itr_vec_s,cnt_s,vec_d1,vec_d2,vec_d3,vec_d4,itr_vec_d,cnt_d,vec_w1,vec_w2,vec_w3,vec_w4,itr_vec_w,cnt_w,vec_l1,vec_l2,vec_l3,vec_l4,itr_vec_l,cnt_l,mf_name_to_update);
    %mf_num = get_updated_parameters_mf(mf_name_to_update);
    mf_num = get_updated_parameters_mf();
    %flag_steplen = get_updated_step_len(sl_vs,itr_vec_sl_vs,cnt_sl_vs,sl_s,itr_vec_sl_s,cnt_sl_s,sl_d,itr_vec_sl_d,cnt_sl_d,sl_w,itr_vec_sl_w,cnt_sl_w,sl_l,itr_vec_sl_l,cnt_sl_l,mf_name_to_update,mf_num);
    %flag_steplen = get_updated_step_len(mf_name_to_update,mf_num);
    flag_steplen = get_updated_step_len();
    %step_len = get_step_length(rssi_new);
    step_len = get_step_length()
    %intmd_dist = get_intmd_distance(step_len,orig_dist);
    intmd_dist = get_intmd_distance()
    rssi_intmd_new = get_intmd_rssi_at_dist(intmd_dist)
    %rssi_intmd_new = get_intmd_rssi_at_dist();
    rssi_det = get_det_rssi_at_dist(intmd_dist)
    %rssi_det = get_det_rssi_at_dist();
    %reward = get_reward(rssi_new,rssi_intmd_new,avg_des);
    reward = get_reward()
    if (reward > 0)
        rl_cnt = rl_cnt +1;
        %orig_dist = get_distance(orig_dist,step_len);
        orig_dist = get_distance(orig_dist)
        itr_vec = [itr_vec rl_cnt];
        %rssi_old = rssi_new
        rssi_new = rssi_intmd_new
        rssi_vec = [rssi_vec rssi_new];
        rssi_vec_det = [rssi_vec_det rssi_det];
        flag = 0;
        copyfile C:\Users\User\sugeno_bkp.fis C:\Users\User\sugeno1.fis
        lr = 0.02;
        lr_vec = [lr_vec 1]
    else
        %rssi_vec = [rssi_vec rssi_new];
        flag = 1;
         copyfile C:\Users\User\sugeno1.fis C:\Users\User\sugeno_bkp.fis
          %lr = lr/abs(reward);
          lr = 0.025;
          lr_vec = [lr_vec 0]
    end
    %lr = lr/abs(reward);
end


%function orig_dist = get_original_distance(orig_dist,step_len)
function orig_dist = get_original_distance(orig_dist)
%function orig_dist = get_original_distance()
    orig_dist = orig_dist + step_len;
end

%function orig_dist = get_distance(orig_dist,step_len)
function orig_dist = get_distance(orig_dist)
    orig_dist = orig_dist + step_len;
    %if (orig_dist <= 0)
        %orig_dist = 1;
    dist_vec = [dist_vec orig_dist];
end

%function intmd_dist = get_intmd_distance(step_len,orig_dist)
function intmd_dist = get_intmd_distance()
    intmd_dist = orig_dist + step_len;
end

%function rssi_new =  get_rssi_at_dist(dist)
function rssi_new =  get_rssi_at_dist()
    %rssi_old = rssi_new
    rssi_new = (10 *2.4 * log10(orig_dist)) - normrnd(0,9.6);
    
    %rssi_new = (10 *2.4 * log10(dist)) -9.6;
end

    function rssi_intmd_new = get_intmd_rssi_at_dist(intmd_dist)
        rssi_intmd_new = (10 *2.4 * log10(intmd_dist))- normrnd(0,9.6);
    end

function rssi_det =  get_det_rssi_at_dist(intmd_dist)
    rssi_det = (10 *2.4 * log10(intmd_dist)); 
    %rssi_intmd_new = (10 *2.4 * log10(dist)) - 9.6;
end

%function step_len = get_step_length(rssi_new)
function step_len = get_step_length()
    out =  readfis('C:\Users\User\sugeno_bkp.fis');
    step_len  = evalfis(abs(rssi_new),out);
end

%function mf_num = get_updated_parameters_mf(vec_vs1,vec_vs2,vec_vs3,vec_vs4,itr_vec_vs,cnt_vs,vec_s1,vec_s2,vec_s3,vec_s4,itr_vec_s,cnt_s,vec_d1,vec_d2,vec_d3,vec_d4,itr_vec_d,cnt_d,vec_w1,vec_w2,vec_w3,vec_w4,itr_vec_w,cnt_w,vec_l1,vec_l2,vec_l3,vec_l4,itr_vec_l,cnt_l,mf_name_to_update)
%function mf_num = get_updated_parameters_mf(mf_name_to_update)
function mf_num = get_updated_parameters_mf()
    line_num = 0;
    %cnt = 0;
    flag =  0;
   
    if (strcmp(mf_name_to_update , 'best'))
        mf_num = 1;
    else if (strcmp(mf_name_to_update , 'strong'))
            mf_num = 2;
        else if (strcmp(mf_name_to_update , 'desirable'))
                mf_num = 3;
            else if (strcmp(mf_name_to_update , 'losing'))
                    mf_num = 4;
                else 
                    mf_num = 5;
                end
            end
        end
    end        
    fid = fopen('C:\Users\User\sugeno_bkp.fis', 'r');
    C = textscan(fid, '%s', 'Delimiter', '\n');
    fclose(fid);
    x = strfind(C{1}, mf_name_to_update);
    var = ~cellfun('isempty', x);
    C = textread('C:\Users\User\sugeno_bkp.fis', '%s', 'delimiter', '\n');
    for i = 1:length(var)
        if (var(i))
            line_num = i;
            break
        end
    end
    line = C{line_num};
    ln_int_vec = str2double(regexp(line,'([0-9]|[0-9][0-9])+','match'));
    ln_vec = ln_int_vec(2:5);
    new_ln_vec = int16(ln_vec + (lr * abs(rssi_new - avg_des)));
    vec_str =  num2str(new_ln_vec);
    [C{line_num}] = strcat ('MF',num2str(mf_num),'=',strcat('''',mf_name_to_update,''''),':','''trapmf''',',','[',vec_str,']');
    if (mf_num == 1)
        cnt_vs = cnt_vs + 1;
        vec_vs1 = [vec_vs1 new_ln_vec(1)];
        vec_vs2 = [vec_vs2 new_ln_vec(2)];
        vec_vs3 = [vec_vs3 new_ln_vec(3)];
        vec_vs4 = [vec_vs4 new_ln_vec(4)];
        itr_vec_vs = [itr_vec_vs cnt_vs];
    else if (mf_num == 2)
            cnt_s = cnt_s + 1;
            vec_s1 = [vec_s1 new_ln_vec(1)];
            vec_s2 = [vec_s2 new_ln_vec(2)];
            vec_s3 = [vec_s3 new_ln_vec(3)];
            vec_s4 = [vec_s4 new_ln_vec(4)];
            itr_vec_s = [itr_vec_s cnt_s];
        else if (mf_num == 3)
                cnt_d = cnt_d + 1;
                vec_d1 = [vec_d1 new_ln_vec(1)];
                vec_d2 = [vec_d2 new_ln_vec(2)];
                vec_d3 = [vec_d3 new_ln_vec(3)];
                vec_d4 = [vec_d4 new_ln_vec(4)];
                itr_vec_d = [itr_vec_d cnt_d];
            else if (mf_num == 4)
                    cnt_w = cnt_w + 1;
                    vec_w1 = [vec_w1 new_ln_vec(1)];
                    vec_w2 = [vec_w2 new_ln_vec(2)];
                    vec_w3 = [vec_w3 new_ln_vec(3)];
                    vec_w4 = [vec_w4 new_ln_vec(4)];
                    itr_vec_w = [itr_vec_w cnt_w];
                else
                    cnt_l =cnt_l + 1;
                    vec_l1 = [vec_l1 new_ln_vec(1)];
                    vec_l2 = [vec_l2 new_ln_vec(2)];
                    vec_l3 = [vec_l3 new_ln_vec(3)];
                    vec_l4 = [vec_l4 new_ln_vec(4)];
                    itr_vec_l = [itr_vec_l cnt_l];
                end
            end
        end
    end
    flid=fopen('C:\Users\User\sugeno_bkp.fis','wt');
    for cnt =  1:length(C)
        fprintf(fid,'%s\n', C{cnt});
    end
      fclose(flid) ;
      
end


%function flag_steplen = get_updated_step_len(sl_vs,itr_vec_sl_vs,cnt_sl_vs,sl_s,itr_vec_sl_s,cnt_sl_s,sl_d,itr_vec_sl_d,cnt_sl_d,sl_w,itr_vec_sl_w,cnt_sl_w,sl_l,itr_vec_sl_l,cnt_sl_l,mf_name_to_update,mf_num)
%function flag_steplen = get_updated_step_len(mf_num)
function flag_steplen = get_updated_step_len()
    line_num = 27 + mf_num;
    if (mf_num == 1)
        steplen_var = 'stepout';
    else if (mf_num == 2)
            steplen_var = 'walk';
        else if(mf_num == 3)
                steplen_var = 'leap';
            else if(mf_num == 4)
                    steplen_var = 'jog';
                else 
                    steplen_var = 'run';
                end
            end
        end       
    end
    C = textread('C:\Users\User\sugeno_bkp.fis', '%s', 'delimiter', '\n');
    line = C{line_num};
    ln_int_vec = str2double(regexp(line,'(*(-)?[0-9]*','match'));
    ln_vec = ln_int_vec(2:3);
    new_ln_vec = int16(ln_vec(2) + (lr * abs(rssi_new - avg_des)));
    vec_str =  strcat ('0',{' '},num2str(new_ln_vec));
    C{line_num} = strcat ('MF',num2str(mf_num),'=',strcat('''',steplen_var,''''),':','''linear''',',','[',[vec_str{:}],']');
    if (mf_num == 1) 
        cnt_sl_vs = cnt_sl_vs + 1; 
        itr_vec_sl_vs = [itr_vec_sl_vs cnt_sl_vs];
        sl_vs = [sl_vs new_ln_vec];
    else if (mf_num == 2)
            cnt_sl_s = cnt_sl_s + 1; 
            itr_vec_sl_s = [itr_vec_sl_s cnt_sl_s];
            sl_s = [sl_s new_ln_vec];
        else if (mf_num == 3)
                cnt_sl_d = cnt_sl_d + 1; 
                itr_vec_sl_d = [itr_vec_sl_d cnt_sl_d];
                sl_d = [sl_d new_ln_vec];
            else if (mf_num == 4)
                    cnt_sl_w = cnt_sl_w + 1; 
                    itr_vec_sl_w = [itr_vec_sl_w cnt_sl_w];
                    sl_w = [sl_w new_ln_vec];
                else
                    cnt_sl_l = cnt_sl_l + 1; 
                    itr_vec_sl_l = [itr_vec_sl_l cnt_sl_l];
                    sl_l = [sl_l new_ln_vec];
                end
            end
        end
    end
    flid=fopen('C:\Users\User\sugeno_bkp.fis','wt');
    for cnt =  1:length(C)
        fprintf(flid,'%s\n', C{cnt});
    end 
      fclose(flid) ;
      flag_steplen =  1;
end

%function reward = get_reward(rssi_new,rssi_intmd_new,avg_des)    
function reward = get_reward()
    reward = abs(rssi_new - avg_des) - abs(rssi_intmd_new - avg_des);
    %reward = abs(rssi_intmd_new - avg_des) - abs(rssi_new - avg_des);
end

function mf_name_to_update = get_mf_name_to_update()
    mf_name_to_update = 'x';
    C = textread('C:\Users\user\sugeno_bkp.fis', '%s','delimiter', '\n');
    for i = 18:22
        line = C{i};
        ln_int_vec = str2double(regexp(line,'([0-9]|[0-9][0-9])+','match'));
        ln_vec = ln_int_vec([2 end]);
        if  (rssi_new >= ln_vec(1) && rssi_new <= ln_vec(2)) 
            mf_name_to_update = C{i}(find(C{i} == '=')+2:find(C{i}==':')-2);
            break
        else
            mf_name_to_update = 'losing';
            
        end
    end    
end
f1 = figure('Name','RSSI and Distance vs ITR');
plot(itr_vec,rssi_vec)
%hold on 
%plot(itr_vec,dist_vec)
hold on
plot(itr_vec,rssi_vec_det);
hold off
xlabel('Iteration')
%legend('RSSI','Distance','RSSI_DET','Location','northeast','Orientation','vertical')
legend('RSSI','RSSI_DET','Location','northeast','Orientation','horizontal')

f2 = figure('Name','MF_Very_Strong vs ITR');
plot(itr_vec_vs,vec_vs1,itr_vec_vs,vec_vs2,itr_vec_vs,vec_vs3,itr_vec_vs,vec_vs4)
ylabel('MF Very Strong')
xlabel('Iteration')

f3 = figure('Name','MF_Strong vs ITR');
plot(itr_vec_s,vec_s1,itr_vec_s,vec_s2,itr_vec_s,vec_s3,itr_vec_s,vec_s4)
ylabel('MF Strong')
xlabel('Iteration')

f4 = figure('Name','MF_Desirable vs ITR');
plot(itr_vec_d,vec_d1,itr_vec_d,vec_d2,itr_vec_d,vec_d3,itr_vec_d,vec_d4)
ylabel('MF Desirable')
xlabel('Iteration')

f5 = figure('Name','MF_Weak vs ITR');
plot(itr_vec_w,vec_w1,itr_vec_w,vec_w2,itr_vec_w,vec_w3,itr_vec_w,vec_w4)
ylabel('MF Weak')
xlabel('Iteration')

f6 = figure('Name','MF_Losing vs ITR');
plot(itr_vec_l,vec_l1,itr_vec_l,vec_l2,itr_vec_l,vec_l3,itr_vec_l,vec_l4)
ylabel('MF Losing')
xlabel('Iteration')

f7 = figure('Name','Step_length_Verystrong vs ITR');
plot(itr_vec_sl_vs,sl_vs)
ylabel('Step length_VeryStrong')
xlabel('Iteration')

f8 = figure('Name','Step_length_Strong vs ITR');
plot(itr_vec_sl_s,sl_s)
ylabel('Step length_Strong')
xlabel('Iteration')

f9 = figure('Name','Step_length_Desired vs ITR');
plot(itr_vec_sl_d,sl_d)
ylabel('Step length_Desired')
xlabel('Iteration')

f10 = figure('Name','Step_length_Weak vs ITR');
plot(itr_vec_sl_w,sl_w)
ylabel('Step length_Weak')
xlabel('Iteration')

f11 = figure('Name','Step_length_Losing vs ITR');
plot(itr_vec_sl_l,sl_l)
ylabel('Step length_Losing')
xlabel('Iteration')

f12 = figure('Name','Learning Rate vs ITR');
plot(real_itr,lr_vec)
ylabel('Learning rate')
xlabel('Iteration')

%plot(itr_vec,dist_vec)
copyfile 'C:\Users\User\sugeno.fis' 'C:\Users\User\sugeno1.fis' 
copyfile 'C:\Users\User\sugeno.fis' 'C:\Users\User\sugeno_bkp.fis'
%plot(itr_vec,dist_vec)
r = 'done';
end
  


%{function avg_des_old = find_median_desirable()
   % C = textscan('C:\Users\user\sugeno.fis', '%s','delimiter', '\n');
    %line = C{20};
   % ln_int_vec = str2double(regexp(line,'([0-9]|[0-9][0-9])+','match'));
   % ln_vec = ln_int_vec(2:5);
    %avg_des = (ln_vec(2)+ ln_vec(5))/2;
%end

%function avg_des_new = find_median_desirable()
    %C = textscan('C:\Users\user\sugeno.fis', '%s','delimiter', '\n');
    %line = C{20};
    %ln_int_vec = str2double(regexp(line,'([0-9]|[0-9][0-9])+','match'));
    %ln_vec = ln_int_vec(2:5);
    %avg_des = (ln_vec(2)+ ln_vec(5))/2;
%end

%function var =  get_mf_name(rssi)
 %   C = textread('C:\Users\User\sugeno.fis', '%s','delimiter', '\n');
  %  for i = 18:22
   %     line = C{i}
    %    ln_int_vec = str2double(regexp(line,'([0-9]|[0-9][0-9])+','match'));
     %   ln_vec = ln_int_vec(2:5);
    %end
%end