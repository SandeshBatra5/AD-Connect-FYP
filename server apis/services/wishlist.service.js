const wishlistmodel = require('../model/wishlist.modal');

class wishlistService{
   static async registerwishlist(number,billboardid){
        try{
            const cretewishlist = new wishlistmodel({number,billboardid});
            return await cretewishlist.save();
        } catch(e){
            console.log(e)
            res.json({status:false,sucess:"server error service register"});
        }
   }

   static async wishlistbyuser(number,billboardid){
    try{
        return await wishlistmodel.findOne({number:number,billboardid:billboardid});
    } catch(e){
        console.log(e)
            res.json({status:false,sucess:"server error service chcekuser"});
    }
   }

   static async wishlistbynumber(number){
    try{
        return await wishlistmodel.find({number});
    } catch(e){
        console.log(e)
            res.json({status:false,sucess:"server error service chcekuser"});
    }
   }

   static async wishlistdelete(id){
    try{
        return await wishlistmodel.findByIdAndDelete(id);
    } catch(e){
        console.log(e)
            res.json({status:false,sucess:"server error service chcekuser"});
    }
   }

}

module.exports = wishlistService;