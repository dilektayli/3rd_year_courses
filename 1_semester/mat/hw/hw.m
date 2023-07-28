% read the file and get the related file
excel_file = 'R2.xlsx';
random_population = xlsread(excel_file, 'B31:KO31');
range = 1:30;

%create the mean and variance arrays. 
mean_population = zeros(1, numel(range));
variance_population = zeros(1, numel(range));

%create random samples and calculate their mean and variance values
for i= 1:numel(range)
    sample = range(i);

    rand_sample = population(randi(numel(random_population),1, sample));

    mean_population(i) = mean(rand_sample);

    variance_population(i) = var(rand_sample);
end

% calculate the mean and variance values of all means and variances of
% different sample sizes
pop_mean = mean(random_population);
pop_variance = var(random_population);

% display the values of mean and variance of the population
disp(['mean of population:', num2str(pop_mean)])
disp(['variance of population:', num2str(pop_variance)])
disp(['means of sample:', num2str(mean_population)])
disp(['variance of sample:', num2str(variance_population)])


% plot the graph to see the changes in the mean and variance when the
% samples size gets larger 
figure();
subplot(1,2,1);
plot(range, mean_population);
title('Mean vs Sample Size');
xlabel('Sample Size');
ylabel('Mean');

subplot(1,2,2);
plot(range, variance_population);
title('Variance vs Sample Size');
xlabel('Sample Size');
ylabel('Variance');
