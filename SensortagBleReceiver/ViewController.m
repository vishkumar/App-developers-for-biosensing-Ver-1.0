//  ViewController.m
//  SensortagBleReceiver
#import "ViewController.h"
#import "AFNetworking.h"
//#import "SensortagBleReceiver-Swift.h"
@interface ViewController (){
    double latitude;
    double longitude;
    double altitude;
    bool eventState;
    NSString * randomText;
    double myText;
    NSArray *allTempData;
    NSData * value;
}

@property (nonatomic,assign) BOOL didUpdateValueForCharacteristic;

@end

@implementation ViewController


NSString *UUID_KEY = @"CC2650 SensorTag";
//NSString *UUID_KEY = @"Sunny's OSHChip";
NSString *UUID = @"";
double myText = 90;
int accRange = 0;
int datacount = 0;
- (void)viewDidLoad {
    [super viewDidLoad];
    eventState = true;
    accRange = ACC_RANGE_4G;
    _myCentralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(senddatatoserver) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];

}

- (void)senddatatoserver{
    
    if (_didUpdateValueForCharacteristic){
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSString * urlStr = @"http://54.70.11.186:8080/BioSensingWeb/index.jsp?";
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    NSDateFormatter * dateformatter = [[NSDateFormatter alloc]init];
    dateformatter.dateFormat = @"MMddyyyyHHmmss";
    NSString * timestamp = [dateformatter stringFromDate:[NSDate date]];
    NSString * datacountStr = [NSString stringWithFormat:@"%d",datacount];
    NSString * parametersstr = [NSString stringWithFormat:@"%@:%@%@:%@:%@:%@:%@:%@:%@:%@:%@:%@:%@:%@:%@:%@:%@",@"00001",timestamp,datacountStr,_tagAccX.stringValue,_tagAccY.stringValue,_tagAccZ.stringValue,_tagGyroX.stringValue,_tagGyroY.stringValue,_tagGyroZ.stringValue,_tagMagX.stringValue,_tagMagY.stringValue,_tagMagZ.stringValue,_tagHum.stringValue,_tagObjTemp.stringValue,_tagAmbTemp.stringValue,_tagBmp,_tagOptical.stringValue];
    parameters[@"parameter"] = parametersstr;
    NSLog(@"parametersstr==%@",parametersstr);
    datacount++;
        
    //self.tempvaluestr = [NSString stringWithFormat:@"%@:", _tagObjTemp.stringValue];
//        NSNotificationCenter * defaulter = [[NSNotificationCenter defaultCenter] postNotificationName:@"sendtempvaluestr" object:_tempvaluestr userInfo:nil];
//       _tempvaluestr = @"123";
    
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    NSLog(@"centralManagerDidUpdateState");
    if([central state] == CBCentralManagerStatePoweredOff){
        NSLog(@"CoreBluetooth BLE hardware is powered off");
    }else if([central state] == CBCentralManagerStatePoweredOn){
        NSLog(@"CoreBluetooth BLE hardware is powered on");
        NSArray *services = @[[CBUUID UUIDWithString:SENSORTAG_SERVICE_UUID]];
        [central scanForPeripheralsWithServices:services options:nil];
    }else if([central state] == CBCentralManagerStateUnauthorized){
        NSLog(@"CoreBluetooth BLE hardware is unauthorized");
    }else if([central state] == CBCentralManagerStateUnknown){
        NSLog(@"CoreBluetooth BLE hardware is unknown");
    }else if([central state] == CBCentralManagerStateUnsupported){
        NSLog(@"CoreBluetooth BLE hardware is unsupported on this platform");
    }
}


- (void) centralManager:(CBCentralManager *)central
  didDiscoverPeripheral:(CBPeripheral *)peripheral
      advertisementData:(NSDictionary *)advertisementData
                   RSSI:(NSNumber *)RSSI
{
    NSLog(@"bluetoothHandler: Found peripheral with UUID : %@ and Name : %@ (%ld dBm)",peripheral.identifier,peripheral.name,(long)[RSSI integerValue]);

    _rssi = RSSI;
    _rssiLabel.text = [NSString stringWithFormat:@"%@ dBm",RSSI.stringValue];
    NSLog(@"Discovered-centralManager === %@", peripheral.name);
    NSLog(@"UUID-centralManager ==== %@", peripheral.identifier);
    NSLog(@"peripheral-centralManager===%@", peripheral);
    _peripheralDevice = peripheral;
    _peripheralDevice.delegate = self;
    [_myCentralManager connectPeripheral:_peripheralDevice options:nil];
//    self.deviceUUIDValue = [NSString stringWithFormat:@"%@", peripheral.identifier];
//    self.deviceNameValue = [NSString stringWithFormat:@"%@", peripheral.name];
////   
    self.deviceUUIDValue = @"ussdf234234";
    self.deviceNameValue = @"Sunny";
    
}

- (void)peripheral:(CBPeripheral *)peripheral didReadRSSI:(NSNumber *)RSSI error:(nullable NSError *)error{
      NSLog(@"bluetoothHandler11111: Found peripheral with UUID : %@ and Name : %@ (%ld dBm)",peripheral.identifier,peripheral.name,(long)[RSSI integerValue]);
    _rssi = RSSI;
    _rssiLabel.text = [NSString stringWithFormat:@"%@ dBm",RSSI.stringValue];
//     self.deviceRSSIValue = [NSString stringWithFormat:@"%@ dBm", RSSI.stringValue];
//    self.deviceRSSIValue = [NSString stringWithFormat:@"%@ dBm", RSSI.stringValue];
//    self.deviceRSSIValue = [NSString stringWithFormat:@"%@", _rssi.stringValue];

}
     
- (void) centralManager:(CBCentralManager *) central
   didConnectPeripheral:(CBPeripheral *)peripheral
{
    NSLog(@"Peripheral connected");
    peripheral.delegate = self;
    [peripheral discoverServices:nil];
    
  
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    for (CBService *service in peripheral.services) {
        NSLog(@"Discoverd serive-didDiscoverServices %@", service.UUID);
        [peripheral discoverCharacteristics:nil forService:service];
    }
}


- (void) peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    
    int enable = ENABLE_SENSOR_CODE;
    int frequency = 0x0A;//0x64; 
    NSData *enableData = [NSData dataWithBytes:&enable length: 1];
    NSData *frequencyData = [NSData dataWithBytes:&frequency length: 1];
    for (CBCharacteristic *characteristic in service.characteristics) {
        NSLog(@"Discovered characteristic--didDiscoverCharacteristicsForService %@", characteristic);
        //[_peripheralDevice readValueForCharacteristic:characteristic];
        if([characteristic.UUID isEqual:[CBUUID UUIDWithString:UUID_HUM_CONF]]){ //
            [peripheral writeValue:enableData forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
            [peripheral setNotifyValue:YES forCharacteristic:[self getCharateristicWithUUID:UUID_HUM_DATA from:service]];
        } else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:UUID_IRT_CONF]]){ //
            [peripheral writeValue:enableData forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
            [peripheral setNotifyValue:YES forCharacteristic:[self getCharateristicWithUUID:UUID_IRT_DATA from:service]];
        } else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:UUID_OPT_CONF]]){ // 
            [peripheral writeValue:enableData forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
            [peripheral setNotifyValue:YES forCharacteristic:[self getCharateristicWithUUID:UUID_OPT_DATA from:service]];
        } else if ( [characteristic.UUID isEqual:[CBUUID UUIDWithString:UUID_BAR_CONF]]){ //
            [peripheral writeValue:enableData forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
            [peripheral setNotifyValue:YES forCharacteristic:[self getCharateristicWithUUID:UUID_BAR_DATA from:service]];
        }
        else if ( [characteristic.UUID isEqual:[CBUUID UUIDWithString:UUID_HEART_RATE_CONF]]){ //
            [peripheral writeValue:enableData forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
            [peripheral setNotifyValue:YES forCharacteristic:[self getCharateristicWithUUID:UUID_HEART_RATE_DATA from:service]];
        }
        else if ( [characteristic.UUID isEqual:[CBUUID UUIDWithString:UUID_MOV_CONF]]){ //
            
            unsigned short e = 0;
            e |= FLAG_ACC_X | FLAG_ACC_Y | FLAG_ACC_Z | FLAG_GYRO_X | FLAG_GYRO_Y | FLAG_GYRO_Z | FLAG_MAG;
            switch (accRange) {
                case ACC_RANGE_2G:
                    break;
                case ACC_RANGE_4G:
                    e |= FLAG_ACC_RANGE_4G;
                    break;
                case ACC_RANGE_8G:
                    e |= FLAG_ACC_RANGE_8G;
                    break;
                case ACC_RANGE_16G:
                    e |= FLAG_ACC_RANGE_16G;
                    break;
                default:
                    break;
            }
            NSLog(@"eeeeeeeeeee====%d",e);
            NSData *ed = [NSData dataWithBytes:&e length: sizeof(e)];
            [peripheral writeValue:ed forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
            [peripheral writeValue:frequencyData forCharacteristic:[self getCharateristicWithUUID:UUID_MOV_PERI from:service] type:CBCharacteristicWriteWithResponse];
            [peripheral setNotifyValue:YES forCharacteristic:[self getCharateristicWithUUID:UUID_MOV_DATA from:service]];
        } else if([characteristic.UUID isEqual:[CBUUID UUIDWithString:UUID_ID_DATA]]){
            int nullBuzzer = 0x00;
            [peripheral writeValue:enableData forCharacteristic:[self getCharateristicWithUUID:UUID_ID_CONF from:service] type:CBCharacteristicWriteWithResponse];
            NSData *nullBuzzerData = [NSData dataWithBytes:&nullBuzzer length: 1];
            [NSThread sleepForTimeInterval:0.5f];
            [peripheral writeValue:nullBuzzerData forCharacteristic:[self getCharateristicWithUUID:UUID_ID_CONF from:service] type:CBCharacteristicWriteWithResponse];
        }
    }
}



- (CBCharacteristic *) getCharateristicWithUUID:(NSString *)uuid from:(CBService *) cbService
{
    for (CBCharacteristic *characteristic in cbService.characteristics) {
        if([characteristic.UUID isEqual:[CBUUID UUIDWithString:uuid]]){
            return characteristic;
        }
    }
    return nil;
}


- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic
             error:(NSError *)error
{
    _didUpdateValueForCharacteristic = YES;
    [peripheral readRSSI];
    
    if([characteristic.UUID isEqual:[CBUUID UUIDWithString:UUID_MOV_DATA]]){
        [self getMotionData:characteristic.value];
    } else if([characteristic.UUID isEqual:[CBUUID UUIDWithString:UUID_HUM_DATA]]){
        [self getHumidityData:characteristic.value];
    } else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:UUID_IRT_DATA]]){
        [self getTemperatureData:characteristic.value];
    } else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:UUID_OPT_DATA]]){
        [self getOpticalData:characteristic.value];
    } else if ( [characteristic.UUID isEqual:[CBUUID UUIDWithString:UUID_BAR_DATA]]){
        [self getBmpData:characteristic.value];
    } else if ( [characteristic.UUID isEqual:[CBUUID UUIDWithString:UUID_HEART_RATE_DATA]]){
        [self getHeartRateData: characteristic.value];
    }
}
- (void) getTemperatureData:(NSData *)data{

    const Byte *orgBytes = [data bytes];
    uint16_t obj = (orgBytes[1] << 8) +orgBytes[0];
    uint16_t ambience = (orgBytes[3] << 8) + orgBytes[2];
    //    NSLog(@"Obj:%f, Amboence:%f,", sensorTmp007ObjConvert(obj), sensorTmp007AmbConvert(ambience));
    _tagObjTemp = [[NSNumber alloc] initWithFloat:sensorTmp007ObjConvert(obj)];
    _tagAmbTemp = [[NSNumber alloc] initWithFloat:sensorTmp007AmbConvert(ambience)];
    
    NSString *str = [NSString stringWithFormat:@"%@", _tagObjTemp.stringValue];
    NSArray *Array = [str componentsSeparatedByString:@"."];
    self.tempvaluestr = [Array objectAtIndex:0];
    
    NSString *typeCasting = (NSString *)data;
  
    NSLog(@"Type Caste %@", typeCasting);
  
    NSData *data1 = [data subdataWithRange:NSMakeRange(1, 1)];
    NSData *data2 = [data subdataWithRange:NSMakeRange(2, 1)];
    
    //int value = CFSwapInt32BigToHost(*(int*)([data4 bytes]));
    
    NSMutableData *concatenatedData = [data2 mutableCopy];
    //[concatenatedData appendData:data2];
    [concatenatedData appendData:data1];
    
//    uint8_t byte;
//    [concatenatedData getBytes:&byte length:1];
//    
//    int x = byte;
    
    NSString *stringData = [concatenatedData description];
    stringData = [stringData substringWithRange:NSMakeRange(1, [stringData length]-2)];
    
    unsigned dataAsInt = 0;
    NSScanner *scanner = [NSScanner scannerWithString: stringData];
    [scanner scanHexInt:& dataAsInt];
    
    float a = [[NSNumber numberWithInt: dataAsInt] floatValue];
    a = a/100;
    self.tempvaluestr = [NSString stringWithFormat:@"%.1f",
                         a];
    
    
    NSLog(@"Temperature data1:::: %@", data1);
    NSLog(@"Temperature data2:::: %@", data2);
    NSLog(@"Temperature String :::: %.1f", a);
    NSLog(@"Temperature converted :::: %@", concatenatedData);

}



- (void) getOpticalData:(NSData *)data {
    const Byte *orgBytes = [data bytes];
    uint16_t rawData = (orgBytes[3] << 24) + (orgBytes[2] << 16) + (orgBytes[1] << 8) +orgBytes[0];
    //    NSLog(@"%f", sensorOpt3001Convert(rawData ));
    _tagOptical = [[NSNumber alloc] initWithFloat:sensorOpt3001Convert(rawData)];
    [_opticalLabel setText:[_tagOptical stringValue]];
    NSString *str = [NSString stringWithFormat:@"%@", _tagOptical.stringValue];
    NSArray *Array = [str componentsSeparatedByString:@"."];
    self.opticalValueStr = [Array objectAtIndex:0];
    
}

- (void) getBmpData:(NSData *)data{
    const Byte *orgBytes = [data bytes];
    int32_t press = (orgBytes[5] << 16) + (orgBytes[4] << 8) +orgBytes[3];
    //    NSLog(@"%f", calcBmp280(press));
    //    int16_t press = (orgBytes[3] << 8) + orgBytes[2];
    _tagBmp = [[NSNumber alloc] initWithFloat:calcBmp280(press)];
    [_bmpLabel setText:[_tagBmp stringValue]];
    //self.pressureValueStr = [NSString stringWithFormat:@"%@", _tagBmp.stringValue];
    
    NSString *str = [NSString stringWithFormat:@"%@", _tagBmp.stringValue];
    NSArray *Array = [str componentsSeparatedByString:@"."];
    self.pressureValueStr = [Array objectAtIndex:0];
}

- (void) getHumidityData:(NSData *)data{
    const Byte *orgBytes = [data bytes];
    //    int16_t temp =(orgBytes[1] << 8) + orgBytes[0];
    int16_t hum = (orgBytes[3] << 8) + orgBytes[2];
    //    sensorHdc1000Convert(temp, hum, tempFloat, humFloat);
    //    NSLog(@"%f C, %f  RH", sensorHdc1000TempConvert(temp), sensorHdc1000HumConvert(hum));
    _tagHum = [[NSNumber alloc] initWithFloat:sensorHdc1000HumConvert(hum)];
    [_humLabel setText:[_tagHum stringValue]];
    self.humidityValueStr = [NSString stringWithFormat:@"%@", _tagHum.stringValue];
    
//    NSString *str = [NSString stringWithFormat:@"%@", _tagHum.stringValue];
//    NSArray *Array = [str componentsSeparatedByString:@"."];
//    self.humidityValueStr = [Array objectAtIndex:0];
}

- (void) getHeartRateData:(NSData *)data{
 
     NSData *data4 = [data subdataWithRange:NSMakeRange(1, 1)];
    
    uint8_t byte;
    [data4 getBytes:&byte length:1];
    
    int x = byte;
    
    self.alcoholValueStr = [NSString stringWithFormat:@"%d", x];
    
    // Get the Heart Rate Monitor BPM
    
    
   // self.alcoholValueStr = data;
    NSLog(@"HeartRate Converted DATA::::: %d", x);
    
    NSLog(@"HeartRate RAW DATA::::: %@", data);
    //    NSString *str = [NSString stringWithFormat:@"%@", _tagHum.stringValue];
    //    NSArray *Array = [str componentsSeparatedByString:@"."];
    //    self.humidityValueStr = [Array objectAtIndex:0];
}

- (void) getMotionData:(NSData *) data
{
    // http://processors.wiki.ti.com/index.php/CC2650_SensorTag_User's_Guide#Movement_Sensor
    const Byte *orgBytes = [data bytes];
    int16_t gyroX = (orgBytes[1] << 8) + orgBytes[0];
    int16_t gyroY = (orgBytes[3] << 8) + orgBytes[2];
    int16_t gyroZ = (orgBytes[5] << 8) + orgBytes[4];
    int16_t accX  = (orgBytes[7] << 8) + orgBytes[6];
    int16_t accY  = (orgBytes[9] << 8) + orgBytes[8];
    int16_t accZ  = (orgBytes[11] << 8) + orgBytes[10];
    int16_t magX  = (orgBytes[13] << 8) + orgBytes[12];
    int16_t magY  = (orgBytes[15] << 8) + orgBytes[14];
    int16_t magZ  = (orgBytes[17] << 8) + orgBytes[16];
    
    NSLog(@"%f %f %f", sensorMpu9250GyroConvert(gyroX),sensorMpu9250GyroConvert(gyroY),sensorMpu9250GyroConvert(gyroZ));
    //    NSLog(@"%f %f %f", sensorMpu9250AccConvert(accX, accRange),sensorMpu9250AccConvert(accY, accRange),sensorMpu9250AccConvert(accZ, accRange));
    //    NSLog(@"%f %f %f", sensorMpu9250MagConvert(magX),sensorMpu9250MagConvert(magY),sensorMpu9250MagConvert(magZ));
    _tagGyroX = [[NSNumber alloc] initWithFloat:sensorMpu9250GyroConvert(gyroX)];
    _tagGyroY = [[NSNumber alloc] initWithFloat:sensorMpu9250GyroConvert(gyroY)];
    _tagGyroZ = [[NSNumber alloc] initWithFloat:sensorMpu9250GyroConvert(gyroZ)];
    
    _tagAccX = [[NSNumber alloc] initWithFloat:sensorMpu9250AccConvert(accX, accRange)];
    _tagAccY = [[NSNumber alloc] initWithFloat:sensorMpu9250AccConvert(accY, accRange)];
    _tagAccZ = [[NSNumber alloc] initWithFloat:sensorMpu9250AccConvert(accZ, accRange)];
    
    _tagMagX = [[NSNumber alloc] initWithFloat:sensorMpu9250MagConvert(magX)];
    _tagMagY = [[NSNumber alloc] initWithFloat:sensorMpu9250MagConvert(magY)];
    _tagMagZ = [[NSNumber alloc] initWithFloat:sensorMpu9250MagConvert(magZ)];
    
    // -- Label --
    [_gyroxLabel setText:[_tagGyroX stringValue]];
    [_gyroyLabel setText:[_tagGyroY stringValue]];
    [_gyrozLabel setText:[_tagGyroZ stringValue]];
    
    [_accxLabel setText:[_tagAccX stringValue]];
    [_accyLabel setText:[_tagAccY stringValue]];
    [_acczLabel setText:[_tagAccZ stringValue]];
    
    [_magxLabel setText:[_tagMagX stringValue]];
    [_magyLabel setText:[_tagMagY stringValue]];
    [_magzLabel setText:[_tagMagZ stringValue]];
    
    
  

    
}

float tempConvert8Bit(uint8_t rawObjTemp)
{
    const float SCALE_LSB = 0.03125;
    float t;
    int it;
    
    it = (int)((rawObjTemp) >> 1);
    t = ((float)(it)) * SCALE_LSB;
    return t;
}

float sensorTmp007ObjConvert(uint16_t rawObjTemp)
{
    const float SCALE_LSB = 0.03125;
    float t;
    int it;
    
    it = (int)((rawObjTemp) >> 2);
    t = ((float)(it)) * SCALE_LSB;
    return t;
}

float sensorTmp007AmbConvert(uint16_t rawAmbTemp)
{
    const float SCALE_LSB = 0.03125;
    float t;
    int it;
    
    it = (int)((rawAmbTemp) >> 2);
    t = (float)it;
    return t * SCALE_LSB;
}


float sensorOpt3001Convert(uint16_t rawData)
{
    uint16_t e, m;
    
    m = rawData & 0x0FFF;
    e = (rawData & 0xF000) >> 12;
    
    return m * (0.01 * pow(2.0,e));
}

float calcBmp280(uint32_t rawValue)
{
    return rawValue / 100.0f;
}

float sensorHdc1000HumConvert(uint16_t rawHum)
{
    //-- calculate relative humidity [%RH]
    return ((double)rawHum / 65536)*100;
}

float sensorHdc1000TempConvert(uint16_t rawTemp)
{
    //-- calculate temperature [°C]
    return ((double)(int16_t)rawTemp / 65536)*165 - 40;
}



float sensorMpu9250GyroConvert(int16_t data)
{
    //-- calculate rotation, unit deg/s, range -250, +250
    return (data * 1.0) / (65536 / 500);
}

float sensorMpu9250AccConvert(int16_t rawData, int accRange)
{
    float v = 0.0;
    
    switch (accRange){
        case ACC_RANGE_2G:
            //-- calculate acceleration, unit G, range -2, +2
            v = (rawData * 1.0) / (32768/2);
            break;
            
        case ACC_RANGE_4G:
            //-- calculate acceleration, unit G, range -4, +4
            v = (rawData * 1.0) / (32768/4);
            break;
            
        case ACC_RANGE_8G:
            //-- calculate acceleration, unit G, range -8, +8
            v = (rawData * 1.0) / (32768/8);
            break;
            
        case ACC_RANGE_16G:
            //-- calculate acceleration, unit G, range -16, +16
            v = (rawData * 1.0) / (32768/16);
            break;
    }
    
    return v;
}


float sensorMpu9250MagConvert(int16_t data)
{
    //-- calculate magnetism, unit uT, range +-4900
    return 1.0 * data;
}



@end
