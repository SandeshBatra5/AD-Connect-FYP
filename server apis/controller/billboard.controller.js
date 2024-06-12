const billboardService = require('../services/billboard.service');

exports.registerbillboard = async(req,res,next)=>{
    try{
        const {number,price,width,height,lon,lat,des,avaliable,image,itemrating,itemuser,reviews,status} = req.body;
        const response = await billboardService.registerbillboard
                    (number,price,width,height,lon,lat,des,avaliable,image,itemrating,itemuser,reviews,status);
        console.log(status);
        res.json({status:true,sucess:"billboard registered Sucessfully"});
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller register"});
    }
}

exports.billboardbynumber = async(req,res,next)=>{
    try{
        const {number} = req.body;
        const billboard = await billboardService.billboardbynumber(number);
        if(!billboard){
            res.status(200).json({status:false,message:"no billboard found"});
        } else{
            res.status(200).json({status:true,data:billboard,message:"sucessfully"});
        }
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller login"});
    }
}


exports.allbillboard = async(req,res,next)=>{
    try{
        const billboard = await billboardService.allbillboard();
        if(!billboard){
            res.status(200).json({status:false,message:"no billboard found"});
        } else{
            res.status(200).json({status:true,data:billboard,message:"sucessfully"});
        }
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller login"});
    }
}


exports.allbillboardadmin = async(req,res,next)=>{
    try{
        const billboard = await billboardService.allbillboardadmin();
        if(!billboard){
            res.status(200).json({status:false,message:"no billboard found"});
        } else{
            res.status(200).json({status:true,data:billboard,message:"sucessfully"});
        }
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller login"});
    }
}



exports.updatebillboard = async(req,res,next)=>{
    try{
        const {id,price,width,height,lon,lat,des,avaliable,image} = req.body;
        const billboard = await billboardService.updatebillboard(id,price,width,height,lon,lat,des,avaliable,image);
        res.status(200).json({status:true});
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller login"});
    }
}


exports.updatebillboardstatus = async(req,res,next)=>{
    try{
        const {id,status} = req.body;
        const billboard = await billboardService.updatebillboardstatus(id,status);
        res.status(200).json({status:true});
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller login"});
    }
}


exports.billboardbyid = async(req,res,next)=>{
    try{
        const {id} = req.body;
        const rest = await billboardService.billboardbyid(id);
        res.status(200).json({status:true,rest:rest});
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller login"});
    }
}


exports.deletebillboard = async(req,res,next)=>{
    try{
        const {id} = req.body;
        const rest = await billboardService.deletebillboard(id);
        res.status(200).json({status:true});
    } catch (e){
        console.log(e)
        res.json({status:false});
    }
}


exports.billboardupdateavaliable = async(req,res,next)=>{
    try{
        const {id,avaliable} = req.body;
        const rest = await billboardService.billboardupdateavaliable(id,avaliable);
        res.status(200).json({status:true});
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller login"});
    }
}

exports.updatedbillboardrating = async(req,res,next)=>{
    try{
        const {id,itemrating,rdata} = req.body;
        const rest = await billboardService.updatedbillboarduuser(id);
        const rest1 = await billboardService.updatedbillboardrating(id,itemrating);
        const rest2 = await billboardService.updatedrlist(id,rdata);
        res.status(200).json({status:true,rest:rest,message:"update in sucessfully"});
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller login"});
    }
}