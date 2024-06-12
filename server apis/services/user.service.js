const usermodel = require('../model/user.modal');
const jwt = require("jsonwebtoken");

class UserService{
   static async registerUser(number,name,img,cnic,pass,address,dob,cat,deviceid,of){
        try{
            const creteuser = new usermodel({number,name,img,cnic,pass,address,dob,cat,deviceid,of});
            return await creteuser.save();
        } catch(e){
            console.log(e)
            res.json({status:false,sucess:"server error service register"});
        }
   }

   static async checkuser(number){
    try{
        return await usermodel.findOne({number});
    } catch(e){
        console.log(e)
            res.json({status:false,sucess:"server error service chcekuser"});
    }
   }

   static async allusers(){
    try{
        return await usermodel.find();
    } catch(e){
        console.log(e)
            res.json({status:false,sucess:"server error service chcekuser"});
    }
   }

   static async updatedevice(userId,deviceid){
    try{
        await usermodel.findByIdAndUpdate(userId, { $set: { deviceid: deviceid } });
    } catch(e){
        console.log(e)
            res.json({status:false,sucess:"server error service chcekuser"});
    }
   }


   static async updateof(number,of){
    try{
        await usermodel.findOneAndUpdate({number:number},{$set:{of:of}});
    } catch(e){
        console.log(e)
            res.json({status:false,sucess:"server error service chcekuser"});
    }
   }


   static async deleteuser(id){
    try{
        await usermodel.findByIdAndDelete(id);
    } catch(e){
        console.log(e)
            res.json({status:false,sucess:"server error service chcekuser"});
    }
   }

   static async generateToken(tokenData,secretKey,jwt_expiry){
    return jwt.sign(tokenData,secretKey,{expiresIn:jwt_expiry});
   }

}

module.exports = UserService;