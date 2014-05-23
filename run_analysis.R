##Read and put in one list all data of "test"
sujeto<-read.table("subject_test.txt", header=F)
colnames(sujeto) <- c("ind")
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
test_data <-list(cbind(sujeto, my_list[[1]]))
for(i in 2:9) {
        completa<-cbind(sujeto, my_list[[i]])
        test_data<-append(test_data, list(completa))
}
##Read and put in one list all data of "training"
sujeto2<-read.table("subject_train.txt", header=F)
colnames(sujeto2) <- c("ind")
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
train_data <-list(cbind(sujeto2, my_list2[[1]]))
for(i in 2:9) {
        completa2<-cbind(sujeto2, my_list2[[i]])
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