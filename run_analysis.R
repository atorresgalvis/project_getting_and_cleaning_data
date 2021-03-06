##Read and put in one list all data of "test"
sujeto<-read.table("subject_test.txt", header=F)
act_labels<-read.table("y_test.txt", header=F)
colnames(sujeto) <- c("ind")
colnames(act_labels) <- c("act")
b_acc_x_t<-read.table("body_acc_x_test.txt", heade=F)
b_acc_y_t<-read.table("body_acc_y_test.txt", heade=F)
b_acc_z_t<-read.table("body_acc_z_test.txt", heade=F)
b_gyr_x_t<-read.table("body_gyro_x_test.txt", heade=F)
b_gyr_y_t<-read.table("body_gyro_y_test.txt", heade=F)
b_gyr_z_t<-read.table("body_gyro_z_test.txt", heade=F)
t_acc_x_t<-read.table("total_acc_x_test.txt", heade=F)
t_acc_y_t<-read.table("total_acc_y_test.txt", heade=F)
t_acc_z_t<-read.table("total_acc_z_test.txt", heade=F)
my_list <- list(b_acc_x_t, b_acc_y_t, b_acc_z_t, b_gyr_x_t, b_gyr_y_t, b_gyr_z_t, t_acc_x_t, t_acc_y_t, t_acc_z_t)
test_data <-list(cbind(sujeto, act_labels, my_list[[1]]))
for(i in 2:9) {
        completa<-cbind(sujeto, act_labels, my_list[[i]])
        test_data<-append(test_data, list(completa))
}
##Read and put in one list all data of "training"
sujeto2<-read.table("subject_train.txt", header=F)
act_labels2<-read.table("y_train.txt", header=F)
colnames(sujeto2) <- c("ind")
colnames(act_labels2) <- c("act")
b_acc_x_tr<-read.table("body_acc_x_train.txt", heade=F)
b_acc_y_tr<-read.table("body_acc_y_train.txt", heade=F)
b_acc_z_tr<-read.table("body_acc_z_train.txt", heade=F)
b_gyr_x_tr<-read.table("body_gyro_x_train.txt", heade=F)
b_gyr_y_tr<-read.table("body_gyro_y_train.txt", heade=F)
b_gyr_z_tr<-read.table("body_gyro_z_train.txt", heade=F)
t_acc_x_tr<-read.table("total_acc_x_train.txt", heade=F)
t_acc_y_tr<-read.table("total_acc_y_train.txt", heade=F)
t_acc_z_tr<-read.table("total_acc_z_train.txt", heade=F)
my_list2 <- list(b_acc_x_tr, b_acc_y_tr, b_acc_z_tr, b_gyr_x_tr, b_gyr_y_tr, b_gyr_z_tr, t_acc_x_tr, t_acc_y_tr, t_acc_z_tr)
train_data <-list(cbind(sujeto2, act_labels2, my_list2[[1]]))
for(i in 2:9) {
        completa2<-cbind(sujeto2, act_labels2, my_list2[[i]])
        train_data<-append(train_data, list(completa2))
}
##merge (put together) both, "test" and "training" data sets
complete_data <-list(rbind(test_data[[1]], train_data[[1]]))
for(i in 2:9) {
        comple<-rbind(test_data[[i]], train_data[[i]])
        complete_data<-append(complete_data, list(comple))
}
names(complete_data) <- c("body_acc_x", "body_acc_y", "body_acc_z", "body_gyro_x", "body_gyro_y", "body_gyro_z", "total_acc_x", "total_acc_y", "total_acc_z")
##write the complete data in two formats/files: .RData file (ready to be called in R or RStudio) and a readable .txt (text) file
save(complete_data, file = "complete_data.RData")
dput(complete_data, file = "complete_data.txt") 
## obtain the means and standard deviation of all variables in the data
total_mean <- NULL
total_sd <- NULL
for (j in 1:9) {
        vec<-complete_data[[j]][[3]]
        for (i in 4:130) {
                new_vec<-complete_data[[j]][[i]]
                vec <-c(vec, new_vec)
        }
        newest_mean<-mean(vec)
        newest_sd<-sd(vec)
        total_mean<-c(total_mean, newest_mean)
        total_sd<-c(total_sd, newest_sd)
}
mean_sd<-matrix(c(total_mean, total_sd), nrow=9, ncol=2, byrow=F) ; colnames(mean_sd)<- c("mean", "sd")
rownames(mean_sd) <- c("body_acc_x", "body_acc_y", "body_acc_z", "body_gyro_x", "body_gyro_y", "body_gyro_z", "total_acc_x", "total_acc_y", "total_acc_z")
write.table(mean_sd, "total_means_sd.txt")
mean_sd
##obtain the means/average of each individual person to each variable.
ind_mean <- NULL
total_ind_mean <- NULL
for (i in 1:9) {
         s<-split(complete_data[[i]], complete_data[[i]][[1]])
         for (j in 1:30) {
                 idv <- s[[j]][[3]]
                 for (k in 4:130) {
                         new_idv<-s[[j]][[k]]
                         idv <-c(idv, new_idv)     
                 }
                 ind_n_mean<-mean(idv)
                 ind_mean <- c(ind_mean, ind_n_mean)
         }
         total_ind_mean <- rbind(total_ind_mean, ind_mean) 

}
rownames(total_ind_mean) <- c("body_acc_x", "body_acc_y", "body_acc_z", "body_gyro_x", "body_gyro_y", "body_gyro_z", "total_acc_x", "total_acc_y", "total_acc_z")
colnames(total_ind_mean)<- paste(c("ind"), 1:30, sep="")
write.table(total_ind_mean, "total_means_by_ind.txt")
total_ind_mean
