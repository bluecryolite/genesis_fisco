发布FISCO-BCOS

1. 管理员的电脑上，需要完整安装一套FISCO-BCOS，参见：
https://github.com/FISCO-BCOS/FISCO-BCOS/tree/master/doc/manual

包括：FISCO-BCOS、NodeJS、cnmp

2. 证书准备
在管理员电脑上完成证书生成。其中的机构证书，可以考虑采用CFCA的证书。
根据企业的情况，生成节点证书。

3. 创世数据准备
3.1 生成god账号
在管理员电脑上生成god账号，并更新至package目录中的genesis.json

3.2 生成创世节点
在管理员节点上，为创世节点生成证书，将node.nodeid更新至genesis.json

4. 安装FISCO-BCOS依赖。用于在机器上首次发布FISCO-BCOS。
需要拷贝package目录到发布机器上
4.1 安装java sdk 1.8，FISCo的建议是oracle jdk 1.8。采用open jdk 1.8暂时还能用，估计是一些加密算法需要用到oracle版本

4.2 执行：sudo apt-get update

4.3 执行package目录中的install.sh

5. 节点安装
需要拷贝template目录和节点证书目录到发布机器上
5.1 在节点机器上执行template目录下的：node-install.sh。其参数依次为：
  targetPath，FISCO-BCOS安装路径
  certPath，证书路径
  existsChainIP, existsChainPort，已存在的节点的IP和端口，用于替换bootstrapnodes.json中的参数。创世节点安装时，填自身的信息。其中，IP需要填写公网IP，端口对公网开放，即，在公网能用telnet连接上。
  localIP, localRpcPort, localP2PPort, localChannelPort，填写新发布节点的信息，其中，IP需要填写公网IP，端口对公网开放，即，在公网能用telnet连接上。

安装完毕后，即可至安装路径下，执行start.sh。注：必须至安装路径下执行，不能在别的路径下用绝对路径的方式调用。

5.2 设置节点为记账节点
如果该节点需要记账，则需要在管理员电脑上设置该节点为记账节点

6. 安装系统合约
创世节点运行后，即可在管理员电脑上安装系统合约，并将合约地址配置至config.json，再发布其他节点

注意：
A. 创世节点需要执行3.4.5.6步骤
B. 其他节点需要执行2.5步骤即可。
C. 其他节点启动后，创世节点和其他节点也就没有区别了，可退出记账，可关闭，可删除
D. 记账节点中，有1/3的节点失去响应时，链会处于挂起状态。此时有个很复杂的上帝模式可恢复使用。见：
https://github.com/FISCO-BCOS/Wiki/tree/master/FISCO%20BCOS%E4%B8%8A%E5%B8%9D%E6%A8%A1%E5%BC%8F%E8%AF%B4%E6%98%8E
