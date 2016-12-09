###############
####聚类分析###
###############

#Fisher于1936年发表的鸢尾花（Iris）数据被广泛地作为聚类和判别分析的例子，数据是对刚毛鸢尾花（Setosa）、变色鸢尾花（Versicolor）、弗吉尼亚鸢尾花（Virginica）三个品种(Species)各抽取1个容量为50的样本，测量其花萼长（Sepal Length）、花萼宽（Sepal Width）、花瓣长（Petal Length）、花瓣宽（Petal Width），单位为mm，以R基础包自带的鸢尾花数据进行聚类分析
#1）系统聚类法
data("iris");attach(iris)#将iris加载到内存

iris.hc<-hclust(dist(iris[,1:4]))#前四列为属性，第五列为品种，分类默认分类方法method=“complete”最长距离
plot(iris.hc,labels=FALSE,hang=-1)#画聚类图
re<-rect.hclust(iris.hc,k=3)#分成三类，每类是个列表list，存放的是对应的行数
iris.id<-cutree(iris.hc,3)#将分成三类的结果变成因子（factor）并赋值于数据表iris新的一列id

table(iris.id,Species)
# 预览按照因子分类后，数量多则认为可以是那一类  Species
# iris.id setosa versicolor virginica
#1     50          0         0
#2      0         23        49
#3      0         27         1


#2）动态聚类法
#install.packages("fpc")
library(fpc)
data(iris)
df<-iris[,c(1:4)]
set.seed(354782)#设置随机值，为了得到一致结果
kmeans<-kmeans(na.omit(df),3)#显示k-均值聚类结果
plotcluster(na.omit(df),kmeans$cluster)#生成聚类图
