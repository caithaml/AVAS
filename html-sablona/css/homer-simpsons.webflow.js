.full-section {
    position: relative;
    overflow: hidden;
    width: 100%;
    height: 100vh;
    background-image: url('../images/simpsons-house-homer-vs-18th-amendment.png');
    background-position: 50% 0px;
    background-size: cover;
  }
  
  .eyeball-wrapper {
    position: absolute;
    left: 0px;
    top: 50%;
    right: 0px;
    display: block;
    width: 240px;
    height: 240px;
    margin-right: auto;
    margin-left: auto;
    -webkit-perspective: 2000px;
    perspective: 2000px;
    -webkit-transform: translate(0px, -50%);
    -ms-transform: translate(0px, -50%);
    transform: translate(0px, -50%);
  }
  
  .eyeball-wrapper.side-by-side {
    position: static;
    left: 0px;
    top: 50%;
    right: 0px;
    width: 230px;
    height: 230px;
    margin-right: 5px;
    margin-left: 5px;
    float: left;
    -webkit-transform: none;
    -ms-transform: none;
    transform: none;
  }
  
  .eyeball {
    width: 100%;
    height: 100%;
    border-radius: 100%;
    background-color: #fff;
    box-shadow: inset 0 -10px 16px 0 rgba(0, 0, 0, .18), 0 36px 32px -25px #979696;
  }
  
  .eyeball.no-shadow {
    border: 5px solid #000;
    box-shadow: none;
  }
  
  .iris {
    position: absolute;
    left: 0px;
    top: 50%;
    right: 0px;
    display: block;
    width: 85px;
    height: 85px;
    margin-right: auto;
    margin-left: auto;
    border-radius: 100%;
    background-image: -webkit-radial-gradient(circle farthest-corner at 50% 50%, #a7cdff, #006ffd);
    background-image: radial-gradient(circle farthest-corner at 50% 50%, #a7cdff, #006ffd);
    -webkit-transform: translate(0px, -50%);
    -ms-transform: translate(0px, -50%);
    transform: translate(0px, -50%);
  }
  
  .iris.red {
    background-image: -webkit-radial-gradient(circle farthest-corner at 50% 50%, #918a7f, #5e4436);
    background-image: radial-gradient(circle farthest-corner at 50% 50%, #918a7f, #5e4436);
  }
  
  .iris.homer {
    width: 50px;
    height: 50px;
    background-image: -webkit-radial-gradient(circle farthest-corner at 50% 50%, #000, #000);
    background-image: radial-gradient(circle farthest-corner at 50% 50%, #000, #000);
  }
  
  .pupil {
    position: absolute;
    left: 0px;
    top: 50%;
    right: 0px;
    display: block;
    width: 35px;
    height: 35px;
    margin-right: auto;
    margin-left: auto;
    border-radius: 100%;
    background-color: #000;
    -webkit-transform: translate(0px, -50%);
    -ms-transform: translate(0px, -50%);
    transform: translate(0px, -50%);
  }
  
  .pupil-gloss {
    position: absolute;
    left: 20px;
    top: 20px;
    z-index: 2;
    width: 25px;
    height: 25px;
    border-radius: 100%;
    background-color: hsla(0, 0%, 100%, .3);
  }
  
  .site-leader {
    position: relative;
    z-index: 3;
    width: 50vw;
    height: 50vh;
    float: left;
  }
  
  .site-leader.third {
    width: 33.33vw;
  }
  
  .site-leader.third.middle {
    position: absolute;
    left: 0px;
    top: 50%;
    right: 0px;
    display: block;
    height: 30vh;
    margin-right: auto;
    margin-left: auto;
    -webkit-transform: translate(0px, -50%);
    -ms-transform: translate(0px, -50%);
    transform: translate(0px, -50%);
  }
  .open-in-webflow {
    position: fixed;
    color: #333;
    top: 10px;
    right: 10px;
    z-index: 10;
    width: auto;
    height: auto;
    padding: 5px 10px;
    cursor: pointer !important;
    border: 2px solid #fff;
    border-radius: 5px;
    background-color: white;
    font-family: sofia-pro, sans-serif;
    text-align: center;
    letter-spacing: 1px;
    box-shadow: 0 20px 60px -2px rgba(27, 33, 58, .3);
  }
  
  .open-in-webflow:hover {
    color: #546DDA;
    
  }
  .double-wrapper {
    position: absolute;
    left: 0px;
    top: 49%;
    right: 0px;
    display: block;
    width: 480px;
    margin-right: auto;
    margin-left: auto;
    -webkit-transform: translate(0px, -50%) scale(0.7);
    -ms-transform: translate(0px, -50%) scale(0.7);
    transform: translate(0px, -50%) scale(0.7);
    -webkit-transform-style: preserve-3d;
    transform-style: preserve-3d;
  }
  
  .double-wrapper.homer {
    top: 47%;
    -webkit-transform-style: preserve-3d;
    transform-style: preserve-3d;
  }
  
  .glasses {
    position: absolute;
    left: -15px;
    top: 50%;
    right: 0px;
    display: block;
    width: 510px;
    margin-right: auto;
    margin-left: auto;
    -webkit-perspective: 1000px;
    perspective: 1000px;
    -webkit-perspective-origin: 50% 0%;
    perspective-origin: 50% 0%;
    -webkit-transform: translate(0px, -50%) rotate(0deg);
    -ms-transform: translate(0px, -50%) rotate(0deg);
    transform: translate(0px, -50%) rotate(0deg);
  }
  
  .lens {
    width: 50%;
    height: 200px;
    float: left;
    border: 10px solid #56ad75;
    border-radius: 0% 0% 100% 100%;
    box-shadow: 0 1px 3px 0 #8d8d8d;
    -webkit-transform: translate(0px, 0px);
    -ms-transform: translate(0px, 0px);
    transform: translate(0px, 0px);
  }
  
  .arms {
    position: absolute;
    left: 0px;
    top: 0px;
    right: 0px;
    display: none;
    width: 100%;
    height: 170px;
    border-top: 10px solid #56ad75;
    border-right: 10px solid #56ad75;
    border-top-right-radius: 50%;
    border-bottom-right-radius: 30px;
    -webkit-transform: translate(46%, 25px) rotateX(0deg) rotateY(80deg) rotateZ(0deg);
    transform: translate(46%, 25px) rotateX(0deg) rotateY(80deg) rotateZ(0deg);
    -webkit-transform-style: preserve-3d;
    transform-style: preserve-3d;
  }
  
  .arms._2 {
    -webkit-transform: translate(-41%, 25px) rotateX(0deg) rotateY(95deg) rotateZ(0deg);
    transform: translate(-41%, 25px) rotateX(0deg) rotateY(95deg) rotateZ(0deg);
    -webkit-transform-style: preserve-3d;
    transform-style: preserve-3d;
  }
  
  .homer-simpson-face {
    position: absolute;
    left: 0px;
    top: 0%;
    right: 0px;
    z-index: -1;
    display: block;
    width: 320px;
    height: 300px;
    max-height: 310px;
    margin-right: auto;
    margin-left: auto;
    border-style: solid;
    border-width: 5px 5px 0px;
    border-color: #000;
    border-radius: 50% 50% 0% 0%;
    background-color: #fcd41d;
    box-shadow: inset -5px 0 0 0 #c7ab19;
  }
  
  .homer-simpson-face.bottom {
    left: 0px;
    top: auto;
    right: 0px;
    bottom: 0%;
    height: 310px;
    border-width: 0px 5px 5px;
    border-radius: 0% 0% 50% 50%;
    box-shadow: inset -4px -4px 0 0 #c7ab19;
  }
  
  .mouth {
    position: absolute;
    left: -25%;
    right: -25%;
    bottom: 6px;
    display: block;
    width: 330px;
    height: 220px;
    margin-right: auto;
    margin-left: auto;
    border: 5px solid #000;
    border-radius: 100%;
    background-color: #d1a64a;
    box-shadow: inset -4px -4px 0 0 #9c8a2d;
  }
  
  .ear {
    position: absolute;
    left: -35px;
    top: 20px;
    bottom: 0px;
    z-index: -15;
    width: 30px;
    height: 65px;
    border-top: 5px solid #000;
    border-bottom: 5px solid #000;
    border-left: 5px solid #000;
    border-radius: 100px 0px 0px 100px;
    background-image: -webkit-linear-gradient(0deg, #f9d41e, #fcd81e);
    background-image: linear-gradient(90deg, #f9d41e, #fcd81e);
  }
  
  .ear._2 {
    left: auto;
    top: 20px;
    right: -35px;
    bottom: 0px;
    -webkit-transform: rotate(180deg);
    -ms-transform: rotate(180deg);
    transform: rotate(180deg);
  }
  
  .smile {
    position: absolute;
    left: 0px;
    top: 58%;
    right: 0px;
    display: block;
    width: 240px;
    height: 70px;
    margin-right: auto;
    margin-left: auto;
    border-bottom: 5px solid #000;
    border-radius: 100%;
    -webkit-transform: translate(0px, -50%);
    -ms-transform: translate(0px, -50%);
    transform: translate(0px, -50%);
  }
  
  .dimple {
    position: absolute;
    top: 0px;
    right: 0px;
    bottom: 0px;
    width: 30px;
    height: 30px;
    border-right: 5px solid #000;
    border-radius: 100%;
    -webkit-transform: rotate(-43deg) translate(0px, 20px);
    -ms-transform: rotate(-43deg) translate(0px, 20px);
    transform: rotate(-43deg) translate(0px, 20px);
  }
  
  .dimple.left {
    left: 0px;
    top: 0px;
    right: auto;
    bottom: 0px;
    -webkit-transform: rotate(213deg) translate(0px, -24px);
    -ms-transform: rotate(213deg) translate(0px, -24px);
    transform: rotate(213deg) translate(0px, -24px);
  }
  
  .chin-dimple {
    position: absolute;
    left: 0px;
    right: 0px;
    bottom: -40px;
    display: block;
    width: 50px;
    height: 30px;
    margin-right: auto;
    margin-left: auto;
    border-bottom: 5px solid #000;
    border-radius: 65%;
  }
  
  .hairs-on-top {
    position: absolute;
    left: 0px;
    top: -35px;
    right: 0px;
    width: 100%;
    height: 55px;
  }
  
  .hair {
    display: block;
    width: 100px;
    height: 80px;
    margin-right: auto;
    margin-left: auto;
    border-top: 5px solid #000;
    border-radius: 100%;
  }
  
  .hair._2 {
    position: absolute;
    left: 0px;
    top: 11px;
    right: 0px;
    height: 60px;
  }
  
  .nose {
    position: absolute;
    left: 0px;
    top: -48px;
    right: 0px;
    z-index: 50;
    display: block;
    width: 90px;
    height: 78px;
    margin-right: auto;
    margin-left: auto;
    border-style: solid;
    border-width: 3px 5px 5px;
    border-color: #fcd41d #000 #000;
    border-radius: 160px;
    background-color: #fbd41c;
    box-shadow: inset 0 -5px 0 0 #c7ab19;
  }
  
  .homer-face {
    position: absolute;
    left: 0px;
    right: 0px;
    bottom: 30px;
    z-index: 1;
    display: block;
    height: 590px;
    max-height: 600px;
    margin-right: auto;
    margin-left: auto;
  }
  
  .eye-brow {
    position: absolute;
    left: -14px;
    bottom: 60px;
    width: 100px;
    height: 42px;
    border-style: solid;
    border-width: 0px 0px 5px 5px;
    border-color: #000;
    border-radius: 100px;
    background-color: #fcd41d;
  }
  
  .eye-brow.right {
    left: auto;
    right: -14px;
    bottom: 60px;
    border-right-width: 5px;
    border-left-width: 0px;
    box-shadow: inset -4px 0 0 0 #c7ab19;
  }
  
  .neck {
    position: absolute;
    left: 0px;
    right: 0px;
    bottom: 0px;
    z-index: 0;
    display: block;
    width: 260px;
    height: 150px;
    margin-right: auto;
    margin-left: auto;
    border-style: solid solid none;
    border-width: 10px 5px;
    border-color: #000;
    background-color: #fcd41d;
  }
  
  .shirt-collar {
    position: absolute;
    left: -30px;
    bottom: -30px;
    width: 150px;
    height: 50px;
    border-top: 5px solid #000;
    border-left: 5px solid #000;
    background-color: #fff;
    -webkit-transform: rotate(20deg);
    -ms-transform: rotate(20deg);
    transform: rotate(20deg);
  }
  
  .shirt-collar._2 {
    left: auto;
    right: -30px;
    bottom: -30px;
    border-right: 5px solid #000;
    border-left-width: 0px;
    -webkit-transform: rotate(-20deg);
    -ms-transform: rotate(-20deg);
    transform: rotate(-20deg);
  }
  
  .t-shirt {
    position: absolute;
    left: -55%;
    right: 50%;
    bottom: -90px;
    width: 80vh;
    background-color: #fff;
  }
  
  .homer-full-container {
    position: absolute;
    left: 0px;
    right: 0px;
    bottom: 0px;
    height: 690px;
    -webkit-perspective: 1500px;
    perspective: 1500px;
    -webkit-perspective-origin: 50% 100%;
    perspective-origin: 50% 100%;
  }
  
  .fixed-div {
    position: fixed;
    left: 0px;
    bottom: 0px;
    width: 20%;
    height: 200px;
    background-color: #0098ff;
  }
  
  .bg {
    position: absolute;
    left: -5%;
    top: -5vh;
    z-index: 0;
    width: 110%;
    height: 110vh;
    background-image: url('../images/simpsons-house.jpg');
    background-position: 50% 50%;
    background-size: cover;
    background-repeat: no-repeat;
  }
  
  html.w-mod-js *[data-ix="lenses-on-face"] {
    -webkit-transform: translate3d(0px, -300%, 10px) rotateX(6deg) rotateY(0deg) rotateZ(0deg);
    transform: translate3d(0px, -300%, 10px) rotateX(6deg) rotateY(0deg) rotateZ(0deg);
  }
  
  html.w-mod-js *[data-ix="homer-on-load"] {
    -webkit-transform: translate(0px, 100%) rotateX(60deg) rotateY(0deg) rotateZ(0deg);
    transform: translate(0px, 100%) rotateX(60deg) rotateY(0deg) rotateZ(0deg);
  }
  
  @media (max-width: 991px) {
    .double-wrapper {
      -webkit-transform: translate(0px, -50%) scale(1);
      -ms-transform: translate(0px, -50%) scale(1);
      transform: translate(0px, -50%) scale(1);
    }
    .double-wrapper.homer {
      -webkit-transform: translate(0px, -50%) scale3d(0.7, 0.7, 1);
      transform: translate(0px, -50%) scale3d(0.7, 0.7, 1);
    }
    .homer-face {
      height: 550px;
    }
  }
  
  @media (max-width: 767px) {
    .double-wrapper {
      -webkit-transform: translate(0px, -50%) scale3d(0.5, 0.5, 1);
      transform: translate(0px, -50%) scale3d(0.5, 0.5, 1);
    }
    .homer-face {
      height: 530px;
    }
  }
  
  @media (max-width: 479px) {
    .eyeball-wrapper.side-by-side.homer-eye {
      display: inline-block;
      width: 110px;
      height: 110px;
      float: none;
    }
    .eyeball.no-shadow {
      border-width: 3px;
    }
    .iris.homer {
      width: 30px;
      height: 30px;
    }
    .pupil {
      width: 25px;
      height: 25px;
    }
    .double-wrapper {
      position: absolute;
      left: 0px;
      top: 50%;
      right: 0px;
      display: block;
      margin-right: auto;
      margin-left: auto;
      -webkit-transform: translate(-15%, -50%) scale(0.5);
      -ms-transform: translate(-15%, -50%) scale(0.5);
      transform: translate(-15%, -50%) scale(0.5);
    }
    .double-wrapper.homer {
      position: absolute;
      left: 0%;
      top: 42%;
      right: 0px;
      width: 100%;
      -webkit-transform: translate(0%, -50%) scale(0.7);
      -ms-transform: translate(0%, -50%) scale(0.7);
      transform: translate(0%, -50%) scale(0.7);
      text-align: center;
    }
    .homer-simpson-face {
      width: 140px;
      height: 160px;
    }
    .homer-simpson-face.bottom {
      bottom: 0%;
      width: 140px;
      height: 170px;
    }
    .mouth {
      bottom: 8px;
      width: 150px;
      height: 120px;
    }
    .ear {
      left: -23px;
      top: 30px;
      width: 19px;
      height: 35px;
    }
    .ear._2 {
      left: auto;
      top: 20px;
      right: -23px;
      bottom: 0px;
    }
    .smile {
      top: 47%;
      width: 90px;
      height: 50px;
    }
    .dimple {
      width: 20px;
      height: 20px;
    }
    .chin-dimple {
      bottom: -25px;
      width: 40px;
    }
    .hairs-on-top {
      top: -32px;
      -webkit-transform: scale(0.7);
      -ms-transform: scale(0.7);
      transform: scale(0.7);
    }
    .hair {
      width: 80px;
      height: 70px;
    }
    .nose {
      top: -18px;
      width: 40px;
      height: 38px;
    }
    .homer-face {
      height: 287px;
      max-height: 560px;
      -webkit-transform: scale(0.7);
      -ms-transform: scale(0.7);
      transform: scale(0.7);
    }
    .eye-brow {
      left: -9px;
      bottom: 63px;
      width: 50px;
      height: 16px;
      border-bottom-width: 3px;
      border-left-width: 4px;
    }
    .eye-brow.right {
      left: auto;
      right: -9px;
      bottom: 63px;
      width: 40px;
      height: 15px;
    }
    .neck {
      display: none;
    }
  }
  
  