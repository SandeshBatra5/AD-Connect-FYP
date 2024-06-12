const ordermodel = require('../model/order.modal');

class orderService{
   static async registeroder(billboardid,custnumber,ownernumber,date,status){
        try{
            const creteorder = new ordermodel({billboardid,custnumber,ownernumber,date,status});
            return await creteorder.save();
        } catch(e){
            console.log(e)
            res.json({status:false,sucess:"server error service register"});
        }
   }

   static async getbyrest(ownernumber){
    try{
        return await ordermodel.find({ownernumber});
    } catch(e){
        console.log(e)
            res.json({status:false,sucess:"server error service chcekuser"});
    }
   }

   static async deleteallorder(ownernumber){
    try{
        return await ordermodel.deleteMany({ownernumber});
    } catch(e){
        console.log(e)
            res.json({status:false,sucess:"server error service chcekuser"});
    }
   }

   static async getbyuser(custnumber){
    try{
        return await ordermodel.find({custnumber});
    } catch(e){
        console.log(e)
            res.json({status:false,sucess:"server error service chcekuser"});
    }
   }


   static async allorder(){
    try{
        return await ordermodel.find();
    } catch(e){
        console.log(e)
            res.json({status:false,sucess:"server error service chcekuser"});
    }
   }

   static async updatestatus(custnumber,ownernumber){
    try{
        return await ordermodel.findOneAndUpdate({ownernumber:ownernumber,custnumber:custnumber},{$set:{status:"aspected"}});
    } catch(e){
        console.log(e)
            res.json({status:false,sucess:"server error service chcekuser"});
    }
   }

}

module.exports = orderService;