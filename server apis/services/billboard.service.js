const billboardmodel = require('../model/billboard.modal');

class billboardService{
   static async registerbillboard(number,price,width,height,lon,lat,des,avaliable,image,itemrating,itemuser,reviews,status){
        try{
            const cretebillboard = new billboardmodel({number,price,width,height,lon,lat,des,avaliable,image,itemrating,itemuser,reviews,status});
            return await cretebillboard.save();
        } catch(e){
            console.log(e)
        }
   }

   static async updatedbillboardrating(id,itemrating){
    try {
        await billboardmodel.findByIdAndUpdate(id,{ $set: {itemrating:itemrating}});
    } catch(e) {
        console.log(e)
        res.json({status:false,sucess:"server error service chcekuser"});
    }
   }

   static async updatedbillboarduuser(id){
    try {
        const u = await billboardmodel.findById(id);
        u.itemuser = (parseInt(u.itemuser) + 1).toString();
        await billboardmodel.findByIdAndUpdate(id,{ $set: {itemuser:u.itemuser}});
    } catch(e) {
        console.log(e)
        res.json({status:false,sucess:"server error service chcekuser"});
    }
   }

   static async updatedrlist(id,data){
    try {
        const u = await billboardmodel.findById(id);
        u.reviews.push(data);
        await billboardmodel.findByIdAndUpdate(id,{$set:{reviews:u.reviews}});
    } catch(e) {
        console.log(e)
        res.json({status:false,sucess:"server error service chcekuser"});
    }
   }

   static async billboardbynumber(number){
    try{
        return await billboardmodel.find({number});
    } catch(e){
        console.log(e)
    }
   }

   static async allbillboard(){
    try{
        return await billboardmodel.find({status:"approve"});
    } catch(e){
        console.log(e)
    }
   }

   static async allbillboardadmin(){
    try{
        return await billboardmodel.find();
    } catch(e){
        console.log(e)
    }
   }


   static async billboardbyid(id){
    try{
        return await billboardmodel.findById(id);
    } catch(e){
        console.log(e)
    }
   }

   static async deletebillboard(id){
    try{
        return await billboardmodel.findByIdAndDelete(id);
    } catch(e){
        console.log(e)
    }
   }

   static async billboardupdateavaliable(id,avaliable){
    try{
        return await billboardmodel.findByIdAndUpdate(id,{$set:{avaliable:avaliable}});
    } catch(e){
        console.log(e)
    }
   }

   static async deleteallbillboard(number){
    try{
        return await billboardmodel.deleteMany({number});
    } catch(e){
        console.log(e)
    }
   }

   static async updatebillboard(id,price,width,height,lon,lat,des,avaliable,image){
    try{
        await billboardmodel.findByIdAndUpdate(id, { $set: { price: price,width:width,height:height,
            lon:lon,lat:lat,des:des,avaliable:avaliable,image:image} });
    } catch(e){
        console.log(e)
    }
   }

   static async updatebillboardstatus(id,status){
    try{
        await billboardmodel.findByIdAndUpdate(id, { $set: {status:status} });
    } catch(e){
        console.log(e)
    }
   }
}

module.exports = billboardService;