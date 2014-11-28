import org.apache.spark.mllib.linalg.{Vectors, Vector}
import org.apache.spark.mllib.regression.LabeledPoint
import org.apache.spark.rdd.RDD
import org.rosuda.REngine.REXP
import org.rosuda.REngine.Rserve.RConnection

object RToScalaRDD {
  def vector(rdd: RDD[Array[Byte]]): RDD[Vector] = {
    rdd.flatMap {bytes =>
      val c = new RConnection()
      c.assign("b", bytes)
      c.voidEval("lst <- unserialize(b)")
      val size = c.eval("length(lst)").asInteger()
      var lst = List[Vector]()
      for(i <- 1 until size) {
        lst ::= Vectors.dense(c.eval(s"lst[[$i]]").asDoubles())
      }
      c.close()
      lst  
    }
  }
  
  def labeledPoint(rdd: RDD[Array[Byte]]): RDD[LabeledPoint] = {
    rdd.flatMap {bytes =>
      val c = new RConnection()
      c.assign("b", bytes)
      c.voidEval("lst <- unserialize(b)")
      val size = c.eval("length(lst)").asInteger()
      var lst = List[LabeledPoint]()
      for(i <- 1 until size) {
        c.voidEval(s"lp <- lst[[$i]]")
        lst ::= LabeledPoint(c.eval("lp[[\"label\"]]").asDouble(), Vectors.dense(c.eval("lp[[\"features\"]]").asDoubles()))
      }
      c.close()
      lst
    }
  }
}