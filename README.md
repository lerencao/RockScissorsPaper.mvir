# RockScissorsPaper.mvir

石头剪刀布:

- 需要双方通过交易来交互。
- 需要抵押 libracoin, 赢的一方可以获取到 libracoin。
- 可以暂时不用考虑游戏数据的公开性导致的作弊问题。


### Start

首先需要本地起一个 libra 节点，然后 client 连进去。


``` bash
# 恢复账号
a r wallet.local
# 给账号充钱
a m 0 1000
a m 1 100


# 编译 rps module
dev c 0 move_scripts/rps.mvir module move_scripts/rps
# 发布 rps module
dev p 0 move_scripts/rps
# 编译三个交互需要用的 script
dev c 0 move_scripts/create.mvir script move_scripts/create
dev c 0 move_scripts/join.mvir script move_scripts/join
dev c 0 move_scripts/reveal.mvir script move_scripts/reveal

## 开始执行合约

# 0 账号在自己的空间中创建一个石头剪刀布游戏，抵押 10000 libcoin
dev e 0 move_scripts/create 10000 b"2a569aac11ee9db3d3d556617fdbc5126b2898c952ba4e04b11d0e0526b3d350"
# 1 账号参与到这个游戏中，给出自己的 hand 2（1: 石头，2: 剪刀，3: 布）
dev e 1 move_scripts/join <replace with 0's account address> 2
# 0 账号揭示自己的 hand，给出秘钥
dev e 0 move_scripts/reveal b"deadbeefdeadbeef" 1
```


### TODO

- timeout 机制。 如果游戏发起方不在规定时间内，reveal 自己的数据，抵押的 coin 自动付给参与者。
- cancel 机制。游戏发起方 cancel 游戏。
