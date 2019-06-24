﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MenuAPI;
using Newtonsoft.Json;
using CitizenFX.Core;
using static CitizenFX.Core.UI.Screen;
using static CitizenFX.Core.Native.API;
using static vMenuClient.CommonFunctions;
using static vMenuShared.PermissionsManager;

namespace vMenuClient
{
    public class NoclipMenu : BaseScript
    {
        private bool setupDone = false;
        private Menu noclipMenu = null;
        private int currentSpeed = 0;

        private List<string> speeds = new List<string>()
        {
            "Very Slow",
            "Slow",
            "Normal",
            "Fast",
            "Very Fast",
            "Extremely Fast",
            "Extremely Fast v2.0",
            "Max Speed"
        };

        /// <summary>
        /// Constructor
        /// </summary>
        public NoclipMenu()
        {
            Tick += OnTick;
        }

        /// <summary>
        /// OnTick to run the menu functions.
        /// </summary>
        /// <returns></returns>
        private async Task OnTick()
        {
            // Setup is not done or cf is null.
            if (!setupDone)
            {
                Setup();

                // wait for setup in MainMenu (permissions and addons) to be done before adding the noclip menu.
                while (!MainMenu.ConfigOptionsSetupComplete || !MainMenu.PermissionsSetupComplete)
                {
                    await Delay(0);
                }
                // Add the noclip menu
                MenuController.AddMenu(noclipMenu);
            }
            // Setup is done.
            else
            {
                if (noclipMenu == null)
                {
                    await Delay(0);
                }
                else
                {
                    while (MainMenu.NoClipEnabled)
                    {
                        noclipMenu.InstructionalButtons[Control.Sprint] = $"Change speed ({speeds[currentSpeed]})";
                        var noclipEntity = Game.PlayerPed.IsInVehicle() ? GetVehicle().Handle : Game.PlayerPed.Handle;

                        if (noclipMenu.Visible == false)
                        {
                            noclipMenu.OpenMenu();
                        }
                        FreezeEntityPosition(noclipEntity, true);
                        SetEntityInvincible(noclipEntity, true);

                        Vector3 newPos = GetEntityCoords(noclipEntity, true);
                        Game.DisableControlThisFrame(0, Control.MoveUpOnly);
                        Game.DisableControlThisFrame(0, Control.MoveUp);
                        Game.DisableControlThisFrame(0, Control.MoveUpDown);
                        Game.DisableControlThisFrame(0, Control.MoveDown);
                        Game.DisableControlThisFrame(0, Control.MoveDownOnly);
                        Game.DisableControlThisFrame(0, Control.MoveLeft);
                        Game.DisableControlThisFrame(0, Control.MoveLeftOnly);
                        Game.DisableControlThisFrame(0, Control.MoveLeftRight);
                        Game.DisableControlThisFrame(0, Control.MoveRight);
                        Game.DisableControlThisFrame(0, Control.MoveRightOnly);
                        Game.DisableControlThisFrame(0, Control.Cover);
                        Game.DisableControlThisFrame(0, Control.MultiplayerInfo);

                        //var xoff = 0.0f;
                        var yoff = 0.0f;
                        var zoff = 0.0f;

                        if (Game.CurrentInputMode == InputMode.MouseAndKeyboard && UpdateOnscreenKeyboard() != 0)
                        {
                            if (Game.IsControlJustPressed(0, Control.Sprint))
                            {
                                currentSpeed++;
                                if (currentSpeed == speeds.Count)
                                {
                                    currentSpeed = 0;
                                }
                                noclipMenu.GetMenuItems()[0].Label = speeds[currentSpeed];
                            }

                            if (Game.IsDisabledControlPressed(0, Control.MoveUpOnly))
                            {
                                yoff = 0.5f;
                            }
                            if (Game.IsDisabledControlPressed(0, Control.MoveDownOnly))
                            {
                                yoff = -0.5f;
                            }
                            if (Game.IsDisabledControlPressed(0, Control.MoveLeftOnly))
                            {
                                SetEntityHeading(Game.PlayerPed.Handle, GetEntityHeading(Game.PlayerPed.Handle) + 3f);
                            }
                            if (Game.IsDisabledControlPressed(0, Control.MoveRightOnly))
                            {
                                SetEntityHeading(Game.PlayerPed.Handle, GetEntityHeading(Game.PlayerPed.Handle) - 3f);
                            }
                            if (Game.IsDisabledControlPressed(0, Control.Cover))
                            {
                                zoff = 0.21f;
                            }
                            if (Game.IsDisabledControlPressed(0, Control.MultiplayerInfo))
                            {
                                zoff = -0.21f;
                            }
                        }
                        float moveSpeed = (float)currentSpeed;
                        if (currentSpeed > speeds.Count / 2)
                        {
                            moveSpeed *= 1.8f;
                        }
                        newPos = GetOffsetFromEntityInWorldCoords(noclipEntity, 0f, yoff * (moveSpeed + 0.3f), zoff * (moveSpeed + 0.3f));

                        var heading = GetEntityHeading(noclipEntity);
                        SetEntityVelocity(noclipEntity, 0f, 0f, 0f);
                        SetEntityRotation(noclipEntity, 0f, 0f, 0f, 0, false);
                        SetEntityHeading(noclipEntity, heading);

                        //if (!((yoff > -0.01f && yoff < 0.01f) && (zoff > -0.01f && zoff < 0.01f)))
                        {
                            SetEntityCollision(noclipEntity, false, false);
                            SetEntityCoordsNoOffset(noclipEntity, newPos.X, newPos.Y, newPos.Z, true, true, true);
                        }

                        // After the next game tick, reset the entity properties.
                        await Delay(0);
                        FreezeEntityPosition(noclipEntity, false);
                        SetEntityInvincible(noclipEntity, false);
                        SetEntityCollision(noclipEntity, true, true);
                    }

                    if (noclipMenu.Visible && !MainMenu.NoClipEnabled)
                    {
                        noclipMenu.CloseMenu();
                    }

                }
            }
        }

        /// <summary>
        /// Setting up the menu.
        /// </summary>
        private void Setup()
        {
            noclipMenu = new Menu("No Clip", "Controls") { IgnoreDontOpenMenus = true };

            MenuItem speed = new MenuItem("Current Moving Speed", "This is your current moving speed.")
            {
                Label = speeds[currentSpeed]
            };

            noclipMenu.OnMenuOpen += (m) =>
            {
                if (MainMenu.NoClipEnabled)
                    HelpMessage.Custom("NoClip is now active. Look at the instructional buttons for all the keybinds. You can view your current moving speed all the way on the bottom right instructional button.");
            };

            noclipMenu.AddMenuItem(speed);

            noclipMenu.InstructionalButtons.Clear();
            noclipMenu.InstructionalButtons.Add(Control.Sprint, $"Change speed ({speeds[currentSpeed]})");
            noclipMenu.InstructionalButtons.Add(Control.MoveUpDown, "Go Forwards/Backwards");
            noclipMenu.InstructionalButtons.Add(Control.MoveLeftRight, "Turn Left/Right");
            noclipMenu.InstructionalButtons.Add(Control.MultiplayerInfo, "Go Down");
            noclipMenu.InstructionalButtons.Add(Control.Cover, "Go Up");
            noclipMenu.InstructionalButtons.Add((Control)MainMenu.NoClipKey, "Disable Noclip");

            setupDone = true;
        }

        public Menu GetMenu()
        {
            return noclipMenu;
        }
    }
}
