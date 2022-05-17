%Combined Plots

fileID = fopen('BER_BPSK.dat','r');
a = fread(fileID,'double');
fclose(fileID);
a = reshape(a,3,[]);
semilogy(a(1,:),a(2,:),'b*',a(1,:),a(3,:),'b-');grid on;
hold on;

fileID = fopen('BER_DPSK.dat','r');
a = fread(fileID,'double');
fclose(fileID);
a = reshape(a,3,[]);
semilogy(a(1,:),a(2,:),'m*',a(1,:),a(3,:),'m-');grid on;
hold on;

fileID = fopen('BER_QPSK.dat','r');
a = fread(fileID,'double');
fclose(fileID);
a = reshape(a,3,[]);
semilogy(a(1,:),a(2,:),'k*',a(1,:),a(3,:),'k-');grid on;

legend('BPSK_T','BPSK_S','DPSK_T','DPSK_S','QPSK_T','QPSK_S');
xlabel('Eb/No (dB)');
ylabel('Bit Error Probability (P_e)');
title('BER Performance');

axis([-4 15 10^-9 1]);

