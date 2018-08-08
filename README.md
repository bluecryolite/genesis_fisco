原本想完成FISCO-BCOS的开发练习，由于计划变更，现已终止了项目开发。以一篇小白入门文作为终止符：[我理解的区块链](https://github.com/bluecryolite/genesis_fisco/wiki/%E6%88%91%E7%90%86%E8%A7%A3%E7%9A%84%E5%8C%BA%E5%9D%97%E9%93%BE)  
  
在此期间，已确认FISCO-BCOS中的Contract类的executeTransaction可用，executeCallSingleValueReturn处理了返回为空的场景。（bcos项目这里是有问题的，需要自己处理。见 [genesis项目](https://github.com/bluecryolite/genesis)）  
  
FISCO-BCOS提供的 [物料包](https://github.com/FISCO-BCOS/fisco-package-build-tool) 用于发布节点，但是**需要在节点所在机器下载源码**，这就不方便了。因此，根据物料包的发布过程，写了个发布脚本，只需要在一台机器上做好发布包，以后其他节点均可直接使用该发布包。  
该脚本`在ubutu 16.04`、`fisco-bcos 1.3.1`下测试通过。

# 发布FISCO-BCOS
本文读者为已有FISCO-BCOS安装经验的同学。  
  
## 1. 发布前准备
发布包的准备，是以创世节点已顺利开启为基础的。  
并且，发布包中不包括证书。这是考虑到证书可能是来源于第三方，因此证书需要单独准备，不在这个发布流程中。

* 管理员的电脑上，需要完整安装一套FISCO-BCOS，并**编译通过**，参见 [FISCO BCOS区块链操作手册](https://github.com/FISCO-BCOS/FISCO-BCOS/tree/master/doc/manual)  
  包括：FISCO-BCOS、NodeJS、cnmp

* 创世节点已运行，系统合约已经发布到链上

## 2. 生成安装包
* 进入deploy目录，运行make_package.sh，参数为：FCOS-BCOS所在的路径。  
```bash
cd deploy
./make_package.sh ~/github/FISCO-BCOS
```
  
* 将god账号更新至template目录中的`genesis.json`，god节点。
  
* 将创世节点的node.nodeid更新至template目录中的`genesis.json`，initMinerNodes节点
  
* 将系统合约地址更新至template目录中的`config.json`，systemproxyaddress节点

## 3. 在新机器上准备环境
* 安装并配置好JAVA SDK，至少是1.8版本。建议安装oracle版本的SDK，估计有些加密功能会用到orcale版本特有的类。
  
* 拷贝已准备好的package目录到目标机器
  
* 执行：sudo apt-get update
  
* 进入到package目录，并执行：install.sh
  
```bash
sudo apt-get update
cd package
./install.sh
```

## 4. 安装节点
* 证书准备  
  可以使用第三方的证书，如CFCA  
  也可以使用FISCO-BCOS提供的脚本生成证书

* 拷贝证书目录和template目录至目标机器
  
* 进入template目录，并执行：node-install.sh。其参数依次为：  
  * `targetPath`，节点安装路径  
  * `certPath`，证书路径  
  * `existsChainIP`, `existsChainPort`，已存在的节点的IP和端口（只需要填写一个当时正在运行的节点），用于替换bootstrapnodes.json中的参数。其中，IP需要填写公网IP，端口对公网开放，即，在公网能用telnet连接上。  
  * `localIP`, `localRpcPort`, `localP2PPort`, `localChannelPort`，填写新发布节点的信息，其中，IP需要填写公网IP，端口对公网开放，即，在公网能用telnet连接上。  
```bash
cd template
./node-install.sh /datas/bcos/node01 ../cert/SellerA/node01 192.168.0.33 30303 192.168.0.34 8546 30305 30306
```
  
* 进入到安装路径下，执行start.sh。  
  注：**必须至安装路径下执行**，不能在别的路径下用绝对路径的方式调用。
  
* 如果该节点需要记账，则需要在管理员电脑上设置该节点为记账节点

## 注意：  
A. 其他节点启动后，创世节点和其他节点也就没有区别了，可退出记账，可关闭，可删除  
B. 记账节点中，有1/3的节点失去响应时，链会处于挂起状态。此时有个很复杂的 [上帝模式](https://github.com/FISCO-BCOS/Wiki/tree/master/FISCO%20BCOS%E4%B8%8A%E5%B8%9D%E6%A8%A1%E5%BC%8F%E8%AF%B4%E6%98%8E) 可恢复使用。

