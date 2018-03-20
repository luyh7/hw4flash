package
{
	public class ExplodeNodes
	{
		public var explodeMovies:Array = new Array();
		private var directs:Array = [[0,2],[2,0],[0,-2],[-2,0],
									 [1,1.732],[1.732,1],[-1,-1.732],[-1.732,-1],
									 [1,-1.732],[1.732,-1],[-1,1.732],[-1.732,1]];
		public var speed:int;
//		private var color:int;

		public function ExplodeNodes(x:int, y:int)
		{
			for(var i:int = 0; i < 12; ++i){
				var explodeMovie:ExplodeMovie = new ExplodeMovie();
				explodeMovie.x = x;
				explodeMovie.y = y;
				this.explodeMovies.push(explodeMovie);
			}
		}
		
		public function diffuse(){
			if(this.alpha == 0){
				return;
			}
			for(var i:int = 0; i < 12; ++i){
				this.explodeMovies[i].x += directs[i][0] * 0.2 * speed;
				this.explodeMovies[i].y += directs[i][1] * 0.2 * speed;
				this.explodeMovies[i].alpha -= 0.005 * speed;
			}
		}
		
		public function set color(color:int){
			for(var i:int = 0; i < 12; ++i){
				FireworkMain.setColor(this.explodeMovies[i] ,color);
			}
		}
		
		public function get alpha(){
			return this.explodeMovies[0].alpha;
		}
		
	}
}