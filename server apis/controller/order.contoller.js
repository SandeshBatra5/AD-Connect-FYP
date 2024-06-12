const orderService = require('../services/order.service');

exports.registeroder = async(req,res,next)=>{
    try{
        const {billboardid,custnumber,ownernumber,date,status} = req.body;
        const response = await orderService.registeroder(billboardid,custnumber,ownernumber,date,status);
        res.json({status:true,sucess:"order registered Sucessfully"});
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller register"});
    }
}

exports.getbyrest = async(req,res,next)=>{
    try{
        const {ownernumber} = req.body;
        const rest = await orderService.getbyrest(ownernumber);
        if(!rest){
            res.status(200).json({status:false,message:"no order found"});
        } else{
            res.status(200).json({status:true,rest:rest,message:"order founded"});
        }
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller login"});
    }
}

exports.getbyuser = async(req,res,next)=>{
    try{
        const {custnumber} = req.body;
        const rest = await orderService.getbyuser(custnumber);
        if(!rest){
            res.status(200).json({status:false,message:"no order found"});
        } else{
            res.status(200).json({status:true,rest:rest,message:"order founded"});
        }
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller login"});
    }
}


exports.updatestatus = async(req,res,next)=>{
    try{
        const {custnumber,ownernumber} = req.body;
        await orderService.updatestatus(custnumber,ownernumber);
        res.status(200).json({status:true,message:"updated status"});
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller login"});
    }
}


exports.allorder = async(req,res,next)=>{
    try{
        const rest = await orderService.allorder();
        res.status(200).json({status:true,rest:rest,message:"order founded"});
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller login"});
    }
}