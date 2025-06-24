% for i=1:100 % get 100 pictures
i=5;
%% open document
fdata=fopen('./sample/data.txt','r');
fweight=fopen('./sample/weight.txt','r');
foutput=fopen('./sample/output.txt','r');

%% get original data
C_data=textscan(fdata,'%bs8');
M_data=C_data{:};
data_matrix=reshape(M_data(((i-1)*64+1):(i*64)),[8,8]);
data_matrix=data_matrix';

C_weight=textscan(fweight,'%bs8');
M_weight=C_weight{1};
weight_conv=reshape(M_weight(1:3*3*3),[3,3,3]);
weight_conv=permute(weight_conv,[2,1,3]);
weight_connect=reshape(M_weight(3*3*3+1:end),[3,3,3]);
weight_connect=permute(weight_connect,[2,1,3]);

C_output=textscan(foutput,'%bs8');
output_check=C_output{:};
output_check=output_check(i);

%% cauculate convolution
conv_ans=int32(zeros(6,6,3));
for d=1:3
    for r=1:6
        for c=1:6
            conv_ans(r,c,d)=int32(sum(int32(data_matrix(r:(r+2),c:(c+2))).*int32(weight_conv(:,:,d)),'all'));
        end
    end
end

%% compress bits
conv_compress=bitshift(int32(conv_ans),-8,"int32");
conv_compress=int8(conv_compress>127)*int8(127)+...
    int8(conv_compress<-128)*int8(-128)+...
    int8(conv_compress>=-128 & conv_compress<=127).*int8(conv_compress);

%% calculate pooling
pool_ans=int8(zeros(3,3,3));
for d=1:3
    for r=1:3
        for c=1:3
            pool_ans(r,c,d)=max(conv_compress((r*2-1):(r*2),(c*2-1):(c*2),d),[],'all');
        end
    end
end

%% calculate connect
connect_ans=int32(sum(int32(pool_ans(:,:,:)).*int32(weight_connect(:,:,:)),'all'));

%% compress bits
connect_compress=bitshift(int32(connect_ans),-8,"int32");
connect_compress=int8(connect_compress>127)*int8(127)+...
    int8(connect_compress<-128)*int8(-128)+...
    int8(connect_compress>=-128 & connect_compress<=127).*int8(connect_compress);

%% output check
if output_check==connect_compress
    fprintf('%d:check OK:calc=%d,standard=%d\n',i,connect_compress,output_check);
else
    fprintf('%d:check fail:calc=%d,standard=%d\n',i,connect_compress,output_check);
end

%% close document
fclose(fdata);
fclose(fweight);
fclose(foutput);


% end
