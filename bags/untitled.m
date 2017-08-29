bag = rosbag('2017-08-29-16-46-48.bag')



odom_msgs = select(bag, 'Topic', '/dragonfly13/odom');
odom = timeseries(odom_msgs, 'Pose.Pose.Position.X', 'Pose.Pose.Position.Y', 'Pose.Pose.Position.Z');

plot3(odom.Data(:,1), odom.Data(:,2), odom.Data(:,3))
axis equal

%%
drift = norm(odom.Data(1,:) - odom.Data(end,:));
dx = diff(odom.Data(:,:));
dist_dx = arrayfun(@(idx) norm(dx(idx,:)), 1:size(dx,1));
dist_travelled = sum(dist_dx);
drift_percent = (drift / dist_travelled)*100

%%
model_names = {'dragonfly13', 'dragonfly14'};
for str=model_names
    disp(str)
end