City:                       # 城市
  - name:str(64)            # 城市名
  - state:bool              # 状态

Area:
  - city:City               # 城市Id
  - name:str(64)            # 区域名
  - state:bool              # 状态

Location:
  - city:City               # 城市Id
  - area:Area               # 区域
  - name:str(64)            # 点位名
  - state:bool              # 状态

Device:
  - name:str(64)            # 设备名称
  - batch:str(64)           # 批次
  - onLine:bool             # 联网状态
  - loadBalance:int         # 负载

DeviceLocation:
  - device:Device           # 设备
  - location:Location       # 位置
  - area:Area               # 位置
  - city:City               # 城市

Merchant:
  - name:str(64)            # 商户名
  - phone:str(18)           # 电话
  - balance:float           # 余额
  - logo:str(256)           # logo
  - state:bool              # 状态

MerchantArea:
  - area:Area               # 所在区域
  - city:City               # 所在城市
  - merchant:Merchant       # 商户

Charging:
  - merchant:Merchant       # 商户
  - fee:float               # 金额
  - ts:int                  # 充值时间
  - before:float            # 充值前余额
  - after:float             # 充值后余额

Consumption:
  - merchant:Merchant       # 商户
  - user:User               # 使用的用户
  - coupon:Coupon           # 优惠卷
  - price:float             # 价格
  - before:float            # 充值前余额
  - after:float             # 充值后余额

CouponType:
  - merchant:Merchant       # 商户
  - opt:str(64)             # 优惠卷描述(抵扣/折扣)
  - val:int                 # 数值
  - totalFee:float          # 总金额
  - amount:int              # 总数量
  - used:int                # 已使用量

Coupon:
  - couponType:CouponType   # 优惠卷类型
  - sn:str(32)              # 优惠卷流水
  - user:User               # 使用的用户
  - ts:int                  # 使用时间
  - useTs:int               # 消费时间

User:
  - phone:str(18)           # 电话
  - weixinId:str(64)        # 微信id
  - nickName:str(64)        # 昵称

CouponPublish:
  - couponType:CouponType   # 优惠卷类型
  - localtion:Location      # 所在点位
  - area:Area               # 所在区域
  - city:City               # 所在城市
  - period:int              # 发布时段

AreaPrice:
  - period:int              # 发布时段
  - area:Area               # 所在区域
  - price:float             # 价格

LocationPrice:
  - period:int              # 发布时段
  - location:Location       # 所在点位
  - price:float             # 价格
  - files:List[str]



