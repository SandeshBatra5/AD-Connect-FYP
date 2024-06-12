const wishlistService = require('../services/wishlist.service');

exports.registerwishlist = async(req,res,next)=>{
    try{
        const {number,billboardid} = req.body;
        const response = await wishlistService.registerwishlist(number,billboardid);
        res.json({status:true,sucess:"wishlist registered Sucessfully"});
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller register"});
    }
}

exports.wishlistbyuser = async(req,res,next)=>{
    try{
        const {number,billboardid} = req.body;
        const rest = await wishlistService.wishlistbyuser(number,billboardid);
        res.status(200).json({status:true,rest:rest,message:"order founded"});
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller login"});
    }
}

exports.wishlistbynumber = async(req,res,next)=>{
    try{
        const {number} = req.body;
        const rest = await wishlistService.wishlistbynumber(number);
        res.status(200).json({status:true,rest:rest,message:"order founded"});
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller login"});
    }
}

exports.wishlistdelete = async(req,res,next)=>{
    try{
        const {id} = req.body;
        await wishlistService.wishlistdelete(id);
        res.status(200).json({status:true,message:"deleted status"});
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller login"});
    }
}
