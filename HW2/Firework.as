package
{
	import flash.display.Sprite;
	public class Firework extends Sprite
	{
		
		/**
		 * 烟花发射的速度
		 */
		private var _speed:int;
		/**
		 * 烟花的颜色
		 */
		private var _color:int;
		/**
		 * 烟花发射的密度
		 */
		private var _interval:int;
		
		private var shotCount:int;
		
		private var raicePoints:Array = new Array;
		private var explodePoints:Array = new Array;
		
		private var firework:* = this;
		private var f1:*;
		private var f2:*;
		public function Firework()
		{
			createTrack();
		}
		
		public function update():void
		{
			createTrack();
			moveTrack();
			explode();
		}
		


		public function get speed():int
		{
			return _speed;
		}

		public function set speed(value:int):void
		{
			_speed = value;
		}

		public function get color():int
		{
			return _color;
		}

		public function set color(value:int):void
		{
			_color = value;
		}

		public function get interval():int
		{
			return _interval;
		}

		public function set interval(value:int):void
		{
			_interval = value;
		}
		
		//创建烟花
		private function createTrack(){
			if(shotCount == 0){
				var raiseMovie:RaiseMovie = new RaiseMovie();
				raiseMovie.x = Math.random() * 450 + 50;
				raiseMovie.y = 423;
				raiseMovie.explodeHeight = int(Math.random() * 200);
				FireworkMain.setColor(raiseMovie,color);
				raicePoints.push(raiseMovie);
				this.addChild(raiseMovie);
			}
			
			if(shotCount < _interval){
				shotCount++;
			}
			else{
				shotCount = 0;
			}
		}
		
		//烟花上升
		private function moveTrack(){
			for each(var track:RaiseMovie in raicePoints){
				track.y -= _speed;
			}
		}
		
		//烟花爆炸
		private function explode(){
			for each(var track:RaiseMovie in raicePoints){
				if(track.y <= track.explodeHeight){
					createExplosion(track);
					this.removeChild(track);
				}
			}
			
			//继续未结束的爆炸
			for each(var exp:ExplodeNodes in explodePoints){
				exp.diffuse();
			}
			
		}
		
		//生成新的爆炸
		private function createExplosion(track:RaiseMovie){
			var explodeNodes:ExplodeNodes = new ExplodeNodes(track.x, track.y);
			explodeNodes.color = _color;
			explodeNodes.speed = _speed;
			//从上升数组移除一个烟花
			for(var i:int = 0; i < raicePoints.length; ++i){
				trace("raicePoints[" + i + "]: " + raicePoints[i]);
				if(raicePoints[i] == track){
					raicePoints.splice(i,1);
//					trace("createExplosion: " + i);
					break;
				}
			}
			
			for(var i:int = 0; i < 12; ++i){
				this.addChild(explodeNodes.explodeMovies[i]);
			}
			explodePoints.push(explodeNodes);
		}
	}
}