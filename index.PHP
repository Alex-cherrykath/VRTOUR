<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script
      src="https://kit.fontawesome.com/64d58efce2.js"
      crossorigin="anonymous"
    ></script>
    <link rel="stylesheet" href="./style/app.css" />
    <title> VRTOUR signin-signup</title>
  </head>
  <body>
    <div class="container">
      <div class="forms-container">
        <div class="signin-signup">
          <form action="./interface/loading.html" class="sign-in-form">
            <h2 class="title">Sign in</h2>
            <div class="input-field">
              <i class="fas fa-user"></i>
              <input type="text" placeholder="Username" name="nom"/>
            </div>
            <div class="input-field">
              <i class="fas fa-lock"></i>
              <input type="text" placeholder="Surname" name="prenom" />
            </div>
            <div class="input-field">
              <i class="fas fa-lock"></i>
              <input type="password" placeholder="Password" name="pass"/>
            </div>
            <input type="submit" value="Login" class="btn solid" />
          </form>
          
          <form action="#" class="sign-up-form">
            <h2 class="title">Sign up</h2>
            <div class="input-field">
              <i class="fas fa-user"></i>
              <input type="text" placeholder="Username" name="name" />
            </div>
            <div class="input-field">
              <i class="fas fa-lock"></i>
              <input type="text" placeholder="Surname" name="prename" />
            </div>
            <div class="input-field">
              <i class="fas fa-envelope"></i>
              <input type="email" placeholder="Email" name="mail"/>
            </div>
            <div class="input-field">
              <i class="fas fa-lock"></i>
              <input type="text" readonly placeholder="Phonenumber" name="tel" />
            </div>
            <div class="input-field">
              <i class="fas fa-lock"></i>
              <input type="ville" readonly placeholder="Town" name="ville" />
            </div>
            <div class="input-rad">
              <i class="fas fa-lock"></i>
              <input type="radio" name="sexe"  class="sexe" id="male" value="M">
              <i class="fas fa-lock"></i>
              <input type="radio" name="sexe" class="sexe" id="female" value="F">
            </div>
            <div class="input-field">
              <i class="fas fa-lock"></i>
              <input type="password" placeholder="Password" name="word" />
            </div>
            <input type="submit" class="btn" value="Sign up" />
          </form>
        </div>
      </div>

      <div class="panels-container">
        <div class="panel left-panel">
          <div class="content">
            <h3>New here ?</h3>
            <p>
              Lorem ipsum, dolor sit amet consectetur adipisicing elit. Debitis,
              ex ratione. Aliquid!
            </p>
            <button class="btn transparent" id="sign-up-btn">
              Sign up
            </button>
          </div>
          <img src="img/log.svg" class="image" alt="" />
        </div>
        <div class="panel right-panel">
          <div class="content">
            <h3>One of us ?</h3>
            <p>
              WELCOME NEW USER IT'S NICE TO MEET THERE 
              PLEASE REGISTER YOU INFORMATION
            </p>
            <button class="btn transparent" id="sign-in-btn">
              Sign in
            </button>
          </div>
          <img src="img/register.svg" class="image" alt="" />
        </div>
      </div>
    </div>

    <script src="./script/app.js"></script>
  </body>
</html>