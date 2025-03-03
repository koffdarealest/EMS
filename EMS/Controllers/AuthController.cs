using System.Security.Claims;
using EMS.Business.Exceptions;
using EMS.Business.Services;
using EMS.Models.Auths;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Mvc;

namespace EMS.Controllers
{
    public class AuthController : Controller
    {
        private readonly IUserAuthService _userAuthService;

        public AuthController(IUserAuthService userAuthService)
        {
            _userAuthService = userAuthService;
        }

        public IActionResult Login()
        {
            if (User.Identity.IsAuthenticated)
            {
                return RedirectToAction("Index", "Home");
            }
            return View();
        }

        public IActionResult AccessDenied()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> LoginAsync(LoginViewModel model)
        {
            if (User.Identity.IsAuthenticated)
            {
                return RedirectToAction("Index", "Home");
            }

            if (ModelState.IsValid)
            {
                try
                {
                    var result = await _userAuthService.ValidateCredentialsAsync(model.Username, model.Password);
                    if (result != null)
                    {
                        var claims = new List<Claim>
                        {
                            new Claim(ClaimTypes.Name, result.Fullname),
                            new Claim(ClaimTypes.NameIdentifier, result.Id.ToString()),
                            new Claim(ClaimTypes.Role, result.Role.ToString())
                        };

                        var claimsIdentity =
                            new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);
                        var authProperties = new AuthenticationProperties
                        {
                            IsPersistent = true,
                            ExpiresUtc = DateTimeOffset.UtcNow.AddMinutes(10)
                        };

                        await HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme,
                            new ClaimsPrincipal(claimsIdentity),
                            authProperties);

                        return RedirectToAction("Index", "Home");
                    }
                    else
                    {
                        ModelState.AddModelError("authError", "Wrong username or password!");
                    }
                }
                catch (DeletedResourceException e)
                {
                    ModelState.AddModelError("authError", e.Message);
                }
                catch (Exception)
                {
                    ModelState.AddModelError("authError", "Invalid username or password!");
                }
            }
            else
            {
                ModelState.AddModelError("authError", "Invalid login attempt!");
            }
            return View(model);
        }

        public async Task<IActionResult> Logout()
        {
            await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
            return RedirectToAction("Login", "Auth");
        }
    }
}
