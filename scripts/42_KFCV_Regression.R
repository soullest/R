bh = read.csv("../data/tema4/BostonHousing.csv")

kfcv.reg =function(df,k){
  fold =sample(1:k,nrow(df),replace = T)
  mse = sapply(1:k,
               kfcv.iter,
               df,fold)
  list("MSE "=mse, "Overall_MSE "= mean(mse),"STD_MSE"=sd(mse))
}

kfcv.iter =function(k,df,fold){
  t.ids = !fold %in% c(k)
  test.ids = fold %in% c(k)
  mod = lm(MEDV ~.,data=df[t.ids,])
  pred = predict(mod,df[test.ids,])
  sqr.err = (pred - df[test.ids,"MEDV"])^2
  mean(sqr.err)
}

res= kfcv.reg(bh,5)
res


loo.reg =function(df){
  mse =sapply(1:nrow(df), loo.iter,df)
  list("MSE"=mse,"Overall_MSE"=mean(mse),"STD_MSE"=sd(mse))
}

loo.iter =function(k,df){
  mod = lm(MEDV~.,data = df[-k,])
  pred = predict(mod,df[k,])
  sqr.err = (pred-df[k,"MEDV"])^2
  sqr.err
}

res=loo.reg(bh)
res
