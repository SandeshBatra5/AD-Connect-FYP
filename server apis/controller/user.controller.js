const UserService = require('../services/user.service');
const billboardService = require('../services/billboard.service');
const orderService = require('../services/order.service');


exports.register = async(req,res,next)=>{
    try{
        const {number,name,img,cnic,pass,address,dob,cat,deviceid,of} = req.body;
        const response = await UserService.registerUser(number,name,img,cnic,pass,address,dob,cat,deviceid,of);
        res.json({status:true,sucess:"User registered Sucessfully"});
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller register"});
    }
}

exports.getonuser = async(req,res,next)=>{
    try{
        const {number} = req.body;
        const rest = await UserService.checkuser(number);
        if(!rest){
            res.status(200).json({status:false,message:"no order found"});
        } else{
            res.status(200).json({status:true,user:rest,message:"order founded"});
        }
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller login"});
    }
}


exports.login = async(req,res,next)=>{
    try{
        const {number,pass,deviceid} = req.body;
        
        const user = await UserService.checkuser(number);
        if(!user){
            res.status(200).json({status:false,message:"no user found"});
        } else{

            const isMatch = await user.comparePassword(pass);
            if(isMatch == false){
                res.status(200).json({status:false,message:"invalid password"});
            } else{
                await UserService.updatedevice(user._id, deviceid);
                let tokenData = {number:user.number,name:user.name,
                    img:user.img,cnic:user.cnic,address:user.address,dob:user.dob,
                    cat:user.cat,deviceid: deviceid};
                const token = await UserService.generateToken(tokenData,"learnandearn","1h")
                res.status(200).json({status:true,token:token,message:"login in sucessfully"});
            }
        }
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller login"});
    }
}


exports.allusers = async(req,res,next)=>{
    try{
        const rest = await UserService.allusers();
        res.status(200).json({status:true,user:rest,message:"order founded"});
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller login"});
    }
}


exports.deleteuser = async(req,res,next)=>{
    try{
        const {id,number} = req.body;
        if(number != ""){
            billboardService.deleteallbillboard(number);
            orderService.deleteallorder(number);
        }
        await UserService.deleteuser(id);
        res.status(200).json({status:true});
    } catch (e){
        console.log(e)
        res.json({status:false});
    }
}


exports.updateof = async(req,res,next)=>{
    try{
        const {number,of} = req.body;
        await UserService.updateof(number,of);
        res.status(200).json({status:true});
    } catch (e){
        console.log(e)
        res.json({status:false});
    }
}