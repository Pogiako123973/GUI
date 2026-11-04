local Plrs = game:GetService("Players")
local TS = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local LocalP = Plrs.LocalPlayer

local T = {
	Bg = Color3.fromRGB(19,19,20),
	Side = Color3.fromRGB(20,20,20),
	El = Color3.fromRGB(25,24,26),
	Sec = Color3.fromRGB(23,23,26),
	Acc = Color3.fromRGB(134,134,255),
	Txt = Color3.fromRGB(255,255,255),
	Sub = Color3.fromRGB(84,86,101),
	Divide = Color3.fromRGB(29,29,37),
	Off = Color3.fromRGB(30,30,36),
}

local F = Enum.Font.Gotham

local function New(cl, pr, ch)
	local o = Instance.new(cl)
	local p
	for k, v in next, pr or {} do
		if k == "Parent" then p = v else o[k] = v end
	end
	for _, c in next, ch or {} do
		c.Parent = o
	end
	if p then o.Parent = p end
	return o
end

local function Crn(r)
	return New("UICorner", {CornerRadius = UDim.new(0, r)})
end

local function Strk(c, th)
	return New("UIStroke", {Color = c or T.Divide, Thickness = th or 1, ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual})
end

local function Twn(o, pr, tm)
	TS:Create(o, TweenInfo.new(tm or 0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), pr):Play()
end

local function KN(k)
	return k and k.Name or "None"
end

local function MakeDrag(ar, tg)
	local dg, ds, sp
	ar.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
			dg = true
			ds = i.Position
			sp = tg.Position
		end
	end)
	UIS.InputChanged:Connect(function(i)
		if dg and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
			local dt = i.Position - ds
			tg.Position = UDim2.new(sp.X.Scale, sp.X.Offset + dt.X, sp.Y.Scale, sp.Y.Offset + dt.Y)
		end
	end)
	UIS.InputEnded:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
			dg = false
		end
	end)
end

local Lib = {}
Lib.Theme = T
Lib.Flags = {}

local Win, Tab, Sec = {}, {}, {}
Win.__index = Win
Tab.__index = Tab
Sec.__index = Sec

function Lib:CreateWindow(cfg)
	cfg = cfg or {}
	local win = setmetatable({}, Win)
	win.Title = cfg.Title or "Vlyte"
	win.Subtitle = cfg.Subtitle or "Baseplate"
	win.Tabs = {}
	win.Elements = {}
	win.KbEntries = {}
	win.ActiveTab = nil
	win.DefSize = cfg.Size or UDim2.new(0, 800, 0, 500)

	local pg = LocalP:WaitForChild("PlayerGui")

	local gui = New("ScreenGui", {
		Name = "VlyteUI",
		ResetOnSpawn = false,
		IgnoreGuiInset = true,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		DisplayOrder = 100,
		Parent = pg,
	})
	win.Gui = gui

	local main = New("Frame", {
		Name = "Main",
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = win.DefSize,
		BackgroundColor3 = T.Bg,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		Parent = gui,
	}, {Crn(15), Strk(T.Divide, 1)})
	win.Main = main

	local side = New("Frame", {
		Name = "Sidebar",
		Size = UDim2.new(0, 210, 1, 0),
		BackgroundColor3 = T.Side,
		BorderSizePixel = 0,
		Parent = main,
	}, {Crn(15)})
	win.Sidebar = side

	local hdr = New("Frame", {
		Name = "Header",
		Size = UDim2.new(1, 0, 0, 52),
		BackgroundTransparency = 1,
		Parent = side,
	})
	MakeDrag(hdr, main)

	New("ImageLabel", {
		Position = UDim2.new(0, 15, 0, 13),
		Size = UDim2.new(0, 26, 0, 26),
		BackgroundTransparency = 1,
		Image = "rbxassetid://74643671263769",
		Parent = hdr,
	})

	New("TextLabel", {
		Position = UDim2.new(0, 51, 0, 13),
		Size = UDim2.new(0, 140, 0, 26),
		BackgroundTransparency = 1,
		Text = win.Title,
		Font = F,
		TextSize = 20,
		TextColor3 = T.Txt,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = hdr,
	})

	local sfr = New("Frame", {
		Position = UDim2.new(0, 0, 0, 52),
		Size = UDim2.new(1, 0, 0, 31),
		BackgroundColor3 = T.El,
		BorderSizePixel = 0,
		Parent = side,
	})

	New("ImageLabel", {
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.new(0, 15, 0.5, 0),
		Size = UDim2.new(0, 14, 0, 14),
		BackgroundTransparency = 1,
		Image = "rbxassetid://10734943674",
		ImageColor3 = T.Sub,
		Parent = sfr,
	})

	local sbox = New("TextBox", {
		Position = UDim2.new(0, 38, 0, 0),
		Size = UDim2.new(1, -50, 1, 0),
		BackgroundTransparency = 1,
		Text = "",
		PlaceholderText = "Search",
		PlaceholderColor3 = T.Sub,
		Font = F,
		TextSize = 14,
		TextColor3 = T.Txt,
		TextXAlignment = Enum.TextXAlignment.Left,
		ClearTextOnFocus = false,
		Parent = sfr,
	})

	New("Frame", {
		Position = UDim2.new(0, 0, 0, 97),
		Size = UDim2.new(1, 0, 0, 1),
		BackgroundColor3 = T.Divide,
		BorderSizePixel = 0,
		Parent = side,
	})

	local th = New("Frame", {
		Position = UDim2.new(0, 0, 0, 112),
		Size = UDim2.new(1, 0, 1, -112),
		BackgroundTransparency = 1,
		Parent = side,
	}, {
		New("UIListLayout", {Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder}),
	})
	win.TabHolder = th

	local ct = New("Frame", {
		Name = "Content",
		Position = UDim2.new(0, 210, 0, 0),
		Size = UDim2.new(1, -210, 1, 0),
		BackgroundTransparency = 1,
		Parent = main,
	})

	local tb = New("Frame", {
		Name = "Topbar",
		Size = UDim2.new(1, 0, 0, 90),
		BackgroundTransparency = 1,
		Parent = ct,
	})

	local da = New("Frame", {
		Name = "DragArea",
		Size = UDim2.new(1, -150, 0, 70),
		BackgroundTransparency = 1,
		Active = true,
		Parent = tb,
	})
	MakeDrag(da, main)

	local tt = New("TextLabel", {
		Position = UDim2.new(0, 18, 0, 20),
		Size = UDim2.new(1, -200, 0, 22),
		BackgroundTransparency = 1,
		Text = "",
		Font = F,
		TextSize = 18,
		TextColor3 = T.Txt,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = da,
	})
	win.TabTitle = tt

	local function CtrlBtn(xo, im, cb)
		local b = New("TextButton", {
			Position = UDim2.new(1, xo, 0, 15),
			Size = UDim2.new(0, 35, 0, 35),
			BackgroundColor3 = T.El,
			BorderSizePixel = 0,
			Text = "",
			AutoButtonColor = false,
			Parent = tb,
		}, {Crn(8)})

		local ic = New("ImageLabel", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			Size = UDim2.new(0, 16, 0, 16),
			BackgroundTransparency = 1,
			Image = im,
			ImageColor3 = T.Sub,
			Parent = b,
		})

		b.MouseEnter:Connect(function()
			Twn(b, {BackgroundColor3 = T.Divide})
			Twn(ic, {ImageColor3 = T.Txt})
		end)
		b.MouseLeave:Connect(function()
			Twn(b, {BackgroundColor3 = T.El})
			Twn(ic, {ImageColor3 = T.Sub})
		end)
		b.MouseButton1Click:Connect(cb)
		return b
	end

	CtrlBtn(-50, "rbxassetid://10734950309", function()
		gui:Destroy()
	end)

	local mini = false
	CtrlBtn(-90, "rbxassetid://99910508437174", function()
		mini = not mini
		side.Visible = not mini
		Twn(main, {Size = mini and UDim2.new(0, 800, 0, 90) or win.DefSize}, 0.25)
	end)

	local pgs = New("Frame", {
		Name = "Pages",
		Position = UDim2.new(0, 0, 0, 90),
		Size = UDim2.new(1, 0, 1, -90),
		BackgroundTransparency = 1,
		Parent = ct,
	})
	win.Pages = pgs

	local kp = New("Frame", {
		Name = "Keybinds",
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(0, 360, 0, 354),
		BackgroundColor3 = T.Bg,
		BorderSizePixel = 0,
		Visible = false,
		Parent = gui,
	}, {Crn(10), Strk(T.Divide, 1)})
	win.KbPanel = kp

	New("ImageLabel", {
		Position = UDim2.new(0, 13, 0, 13),
		Size = UDim2.new(0, 18, 0, 18),
		BackgroundTransparency = 1,
		Image = "rbxassetid://10723433811",
		ImageColor3 = T.Acc,
		Parent = kp,
	})

	New("TextLabel", {
		Position = UDim2.new(0, 39, 0, 11),
		Size = UDim2.new(0, 220, 0, 22),
		BackgroundTransparency = 1,
		Text = "Keybind list",
		Font = F,
		TextSize = 16,
		TextColor3 = T.Txt,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = kp,
	})

	local kc = New("ImageButton", {
		Position = UDim2.new(0, 330, 0, 13),
		Size = UDim2.new(0, 18, 0, 18),
		BackgroundTransparency = 1,
		Image = "rbxassetid://125910158111031",
		Parent = kp,
	})
	kc.MouseButton1Click:Connect(function()
		kp.Visible = false
	end)

	New("Frame", {
		Position = UDim2.new(0, 10, 0, 44),
		Size = UDim2.new(0, 340, 0, 1),
		BackgroundColor3 = T.Divide,
		BorderSizePixel = 0,
		Parent = kp,
	})

	local hs = {
		{10, 100, "Function", Enum.TextXAlignment.Left},
		{115, 90, "Hotkey", Enum.TextXAlignment.Center},
		{250, 65, "Status", Enum.TextXAlignment.Center},
	}
	for _, h in ipairs(hs) do
		New("TextLabel", {
			Position = UDim2.new(0, h[1], 0, 52),
			Size = UDim2.new(0, h[2], 0, 24),
			BackgroundTransparency = 1,
			Text = h[3],
			Font = F,
			TextSize = 14,
			TextColor3 = T.Sub,
			TextXAlignment = h[4],
			Parent = kp,
		})
	end

	local kl = New("ScrollingFrame", {
		Position = UDim2.new(0, 0, 0, 80),
		Size = UDim2.new(1, 0, 1, -80),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ScrollBarThickness = 0,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		ScrollingDirection = Enum.ScrollingDirection.Y,
		Parent = kp,
	}, {
		New("UIListLayout", {SortOrder = Enum.SortOrder.LayoutOrder}),
	})
	win.KbList = kl

	CtrlBtn(-130, "rbxassetid://10723433811", function()
		kp.Visible = not kp.Visible
	end)

	if cfg.Watermark ~= false then
		local wm = New("Frame", {
			Name = "Watermark",
			AnchorPoint = Vector2.new(0.5, 0),
			Position = UDim2.new(0.5, 0, 0, 12),
			Size = UDim2.new(0, 0, 0, 34),
			AutomaticSize = Enum.AutomaticSize.X,
			BackgroundColor3 = T.Bg,
			BorderSizePixel = 0,
			Parent = gui,
		}, {
			Crn(8),
			Strk(T.Divide, 1),
			New("UIPadding", {PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 12)}),
			New("UIListLayout", {
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalAlignment = Enum.HorizontalAlignment.Left,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				Padding = UDim.new(0, 10),
				SortOrder = Enum.SortOrder.LayoutOrder,
			}),
		})

		New("ImageLabel", {
			Size = UDim2.new(0, 16, 0, 16),
			BackgroundTransparency = 1,
			Image = "rbxassetid://74643671263769",
			Parent = wm,
		})

		local function wmLb(tx, cl)
			return New("TextLabel", {
				Size = UDim2.new(0, 0, 0, 16),
				AutomaticSize = Enum.AutomaticSize.X,
				BackgroundTransparency = 1,
				Text = tx,
				Font = F,
				TextSize = 13,
				TextColor3 = cl or T.Sub,
				Parent = wm,
			})
		end

		local function wmSp()
			New("Frame", {
				Size = UDim2.new(0, 1, 0, 14),
				BackgroundColor3 = T.Divide,
				BorderSizePixel = 0,
				Parent = wm,
			})
		end

		wmLb(win.Title, T.Txt); wmSp()
		wmLb(win.Subtitle); wmSp()
		local fl = wmLb("0 fps"); wmSp()
		local pl = wmLb("0 ms"); wmSp()
		local tl = wmLb("00:00:00")

		local fr = 0
		local ck = 0
		RS.RenderStepped:Connect(function(dt)
			fr = fr + 1
			ck = ck + dt
			if ck >= 0.5 then
				fl.Text = math.floor(fr / ck + 0.5) .. " fps"
				fr = 0
				ck = 0
				local ok, p = pcall(function()
					return LocalP:GetNetworkPing() * 1000
				end)
				if ok and p then
					pl.Text = math.floor(p + 0.5) .. " ms"
				end
				tl.Text = os.date("%H:%M:%S")
			end
		end)
	end

	UIS.InputBegan:Connect(function(i, pr)
		if pr then return end
		for _, en in ipairs(win.KbEntries) do
			if i.KeyCode == en.Key then
				en.Element:Set(not en.Element.Value)
			end
		end
	end)

	sbox:GetPropertyChangedSignal("Text"):Connect(function()
		local q = sbox.Text:lower()
		for _, tb in ipairs(win.Tabs) do
			for _, sc in ipairs(tb.Sections) do
				local av = false
				for _, el in ipairs(sc.Elements) do
					local m = q == "" or el.Name:lower():find(q, 1, true) ~= nil
					el.Row.Visible = m
					if m then av = true end
				end
				sc.Frame.Visible = av
			end
		end
	end)

	return win
end

function Win:SelectTab(tb)
	for _, t in ipairs(self.Tabs) do
		local ac = (t == tb)
		t.Page.Visible = ac
		Twn(t.Ind, {BackgroundTransparency = ac and 0 or 1})
		Twn(t.IcL, {ImageColor3 = ac and T.Txt or T.Sub})
		Twn(t.Lb, {TextColor3 = ac and T.Txt or T.Sub})
		Twn(t.Btn, {BackgroundTransparency = ac and 0 or 1})
	end
	self.TabTitle.Text = tb.Name
	self.ActiveTab = tb
end

function Win:AddKeybind(el, key)
	local en = {Element = el, Key = key, Name = el.Name}
	self.KbEntries[#self.KbEntries + 1] = en

	local row = New("Frame", {
		Size = UDim2.new(1, 0, 0, 30),
		BackgroundTransparency = 1,
		LayoutOrder = #self.KbEntries,
		Parent = self.KbList,
	})

	New("TextLabel", {
		Position = UDim2.new(0, 10, 0, 0),
		Size = UDim2.new(0, 100, 1, 0),
		BackgroundTransparency = 1,
		Text = en.Name,
		Font = F,
		TextSize = 14,
		TextColor3 = T.Txt,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = row,
	})
	New("TextLabel", {
		Position = UDim2.new(0, 115, 0, 0),
		Size = UDim2.new(0, 90, 1, 0),
		BackgroundTransparency = 1,
		Text = KN(key),
		Font = F,
		TextSize = 14,
		TextColor3 = T.Txt,
		TextXAlignment = Enum.TextXAlignment.Center,
		Parent = row,
	})
	New("TextLabel", {
		Position = UDim2.new(0, 250, 0, 0),
		Size = UDim2.new(0, 65, 1, 0),
		BackgroundTransparency = 1,
		Text = "Toggle",
		Font = F,
		TextSize = 14,
		TextColor3 = T.Acc,
		TextXAlignment = Enum.TextXAlignment.Center,
		Parent = row,
	})

	return en
end

function Win:CreateTab(nm, ic)
	local tb = setmetatable({}, Tab)
	tb.Window = self
	tb.Name = nm
	tb.Icon = ic or "rbxassetid://134242818164054"
	tb.Sections = {}
	tb.Elements = {}
	tb.ColCnt = 0

	local b = New("Frame", {
		Name = nm .. "Tab",
		Size = UDim2.new(1, 0, 0, 31),
		BackgroundColor3 = T.El,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		LayoutOrder = #self.Tabs + 1,
		Parent = self.TabHolder,
	})

	local ind = New("Frame", {
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.new(0, 0, 0.5, 0),
		Size = UDim2.new(0, 3, 0, 17),
		BackgroundColor3 = T.Acc,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Parent = b,
	}, {Crn(4)})

	local icl = New("ImageLabel", {
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.new(0, 18, 0.5, 0),
		Size = UDim2.new(0, 15, 0, 15),
		BackgroundTransparency = 1,
		Image = tb.Icon,
		ImageColor3 = T.Sub,
		Parent = b,
	})

	local lb = New("TextLabel", {
		Position = UDim2.new(0, 48, 0, 0),
		Size = UDim2.new(1, -55, 1, 0),
		BackgroundTransparency = 1,
		Text = nm,
		Font = F,
		TextSize = 14,
		TextColor3 = T.Sub,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = b,
	})

	local ck = New("TextButton", {
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		Text = "",
		Parent = b,
	})
	ck.MouseButton1Click:Connect(function()
		self:SelectTab(tb)
	end)

	tb.Btn, tb.Ind, tb.IcL, tb.Lb = b, ind, icl, lb

	local pg = New("Frame", {
		Name = nm .. "Page",
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		Visible = false,
		Parent = self.Pages,
	})
	tb.Page = pg

	local function mkCol(x)
		return New("ScrollingFrame", {
			Position = UDim2.new(0, x, 0, 0),
			Size = UDim2.new(0, 295, 1, 0),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ScrollBarThickness = 0,
			CanvasSize = UDim2.new(0, 0, 0, 0),
			AutomaticCanvasSize = Enum.AutomaticSize.Y,
			ScrollingDirection = Enum.ScrollingDirection.Y,
			Parent = pg,
		}, {
			New("UIPadding", {
				PaddingTop = UDim.new(0, 2),
				PaddingBottom = UDim.new(0, 12),
				PaddingLeft = UDim.new(0, 8),
				PaddingRight = UDim.new(0, 8),
			}),
			New("UIListLayout", {Padding = UDim.new(0, 14), SortOrder = Enum.SortOrder.LayoutOrder}),
		})
	end

	tb.Cols = {mkCol(0), mkCol(295)}

	self.Tabs[#self.Tabs + 1] = tb
	if #self.Tabs == 1 then
		self:SelectTab(tb)
	end

	return tb
end

function Tab:CreateSection(nm, op)
	op = op or {}
	local ci = op.Column
	if not ci then
		self.ColCnt = (self.ColCnt % 2) + 1
		ci = self.ColCnt
	end
	local col = self.Cols[math.clamp(ci, 1, 2)]

	local sc = setmetatable({}, Sec)
	sc.Tab = self
	sc.Name = nm
	sc.Rows = {}
	sc.Elements = {}

	local wr = New("Frame", {
		Name = nm .. "Section",
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		LayoutOrder = #self.Sections + 1,
		Parent = col,
	}, {
		New("UIListLayout", {Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder}),
	})

	New("TextLabel", {
		Size = UDim2.new(1, 0, 0, 19),
		BackgroundTransparency = 1,
		Text = nm,
		Font = F,
		TextSize = 15,
		TextColor3 = T.Sub,
		TextXAlignment = Enum.TextXAlignment.Left,
		LayoutOrder = 1,
		Parent = wr,
	})

	local cn = New("Frame", {
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundColor3 = T.Sec,
		BorderSizePixel = 0,
		LayoutOrder = 2,
		Parent = wr,
	}, {
		Crn(10),
		New("UIPadding", {PaddingTop = UDim.new(0, 6), PaddingBottom = UDim.new(0, 6)}),
		New("UIListLayout", {SortOrder = Enum.SortOrder.LayoutOrder}),
	})

	sc.Frame = wr
	sc.Container = cn
	sc.LastRow = nil

	self.Sections[#self.Sections + 1] = sc
	return sc
end

function Sec:AddRow(rw)
	if self.LastRow then
		New("Frame", {
			Position = UDim2.new(0, 15, 1, -1),
			Size = UDim2.new(1, -30, 0, 1),
			BackgroundColor3 = T.Divide,
			BorderSizePixel = 0,
			Parent = self.LastRow,
		})
	end
	rw.LayoutOrder = #self.Rows + 1
	rw.Parent = self.Container
	self.Rows[#self.Rows + 1] = rw
	self.LastRow = rw
	return rw
end

function Sec:_AddEl(el)
	self.Elements[#self.Elements + 1] = el
	self.Tab.Elements[#self.Tab.Elements + 1] = el
	return el
end

function Sec:CreateToggle(cfg)
	cfg = cfg or {}
	local nm = cfg.Name or "Toggle"
	local fl = cfg.Flag or nm
	local vl = cfg.Default == true
	local cb = cfg.Callback or function() end
	local kb = cfg.Keybind

	local rw = New("Frame", {
		Size = UDim2.new(1, 0, 0, 37),
		BackgroundTransparency = 1,
	})

	local bx = New("Frame", {
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.new(0, 15, 0.5, 0),
		Size = UDim2.new(0, 17, 0, 17),
		BackgroundColor3 = T.Off,
		BorderSizePixel = 0,
		Parent = rw,
	}, {Crn(4)})

	local ch = New("ImageLabel", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(0, 12, 0, 12),
		BackgroundTransparency = 1,
		Image = "rbxassetid://10709790644",
		ImageColor3 = Color3.new(1, 1, 1),
		ImageTransparency = 1,
		Parent = bx,
	})

	local lb = New("TextLabel", {
		Position = UDim2.new(0, 41, 0, 0),
		Size = UDim2.new(1, -110, 1, 0),
		BackgroundTransparency = 1,
		Text = nm,
		Font = F,
		TextSize = 14,
		TextColor3 = T.Sub,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = rw,
	})

	local klb
	if kb then
		klb = New("TextLabel", {
			AnchorPoint = Vector2.new(1, 0.5),
			Position = UDim2.new(1, -15, 0.5, 0),
			Size = UDim2.new(0, 28, 0, 20),
			BackgroundColor3 = T.El,
			BorderSizePixel = 0,
			Text = KN(kb),
			Font = F,
			TextSize = 12,
			TextColor3 = T.Sub,
			Parent = rw,
		}, {Crn(4)})
	end

	local bt = New("TextButton", {
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		Text = "",
		Parent = rw,
	})

	local el = {
		Type = "Toggle",
		Name = nm,
		Flag = fl,
		Row = rw,
		Value = vl,
		Callback = cb,
	}

	function el:Set(v, sl)
		self.Value = v
		Lib.Flags[fl] = v
		Twn(bx, {BackgroundColor3 = v and T.Acc or T.Off})
		Twn(ch, {ImageTransparency = v and 0 or 1})
		Twn(lb, {TextColor3 = v and T.Txt or T.Sub})
		if klb then
			Twn(klb, {TextColor3 = v and T.Acc or T.Sub})
		end
		if not sl then
			cb(v)
		end
	end

	bt.MouseButton1Click:Connect(function()
		el:Set(not el.Value)
	end)

	el:Set(vl, true)
	self:AddRow(rw)
	self:_AddEl(el)

	if kb then
		self.Tab.Window:AddKeybind(el, kb)
	end

	return el
end

function Sec:CreateButton(cfg)
	cfg = cfg or {}
	local nm = cfg.Name or "Button"
	local cb = cfg.Callback or function() end

	local rw = New("Frame", {
		Size = UDim2.new(1, 0, 0, 43),
		BackgroundTransparency = 1,
	})

	local b = New("TextButton", {
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.new(0, 15, 0.5, 0),
		Size = UDim2.new(1, -30, 0, 28),
		BackgroundColor3 = T.El,
		BorderSizePixel = 0,
		Text = nm,
		Font = F,
		TextSize = 14,
		TextColor3 = T.Sub,
		AutoButtonColor = false,
		Parent = rw,
	}, {Crn(6)})

	b.MouseEnter:Connect(function()
		Twn(b, {BackgroundColor3 = T.Divide})
		Twn(b, {TextColor3 = T.Txt})
	end)
	b.MouseLeave:Connect(function()
		Twn(b, {BackgroundColor3 = T.El})
		Twn(b, {TextColor3 = T.Sub})
	end)
	b.MouseButton1Click:Connect(cb)

	self:AddRow(rw)
	local el = {Type = "Button", Name = nm, Row = rw}
	return self:_AddEl(el)
end

function Sec:CreateLabel(tx)
	local rw = New("Frame", {
		Size = UDim2.new(1, 0, 0, 30),
		BackgroundTransparency = 1,
	})

	New("TextLabel", {
		Position = UDim2.new(0, 15, 0, 0),
		Size = UDim2.new(1, -30, 1, 0),
		BackgroundTransparency = 1,
		Text = tx or "",
		Font = F,
		TextSize = 14,
		TextColor3 = T.Sub,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextWrapped = true,
		Parent = rw,
	})

	self:AddRow(rw)
	local el = {Type = "Label", Name = tx or "", Row = rw}
	return self:_AddEl(el)
end

function Sec:CreateSlider(cfg)
	cfg = cfg or {}
	local nm = cfg.Name or "Slider"
	local fl = cfg.Flag or nm
	local mn = cfg.Min or 0
	local mx = cfg.Max or 100
	local st = cfg.Step or 1
	local vl = cfg.Default or mn
	local sf = cfg.Suffix or ""
	local cb = cfg.Callback or function() end

	local rw = New("Frame", {
		Size = UDim2.new(1, 0, 0, 48),
		BackgroundTransparency = 1,
	})

	New("TextLabel", {
		Position = UDim2.new(0, 15, 0, 8),
		Size = UDim2.new(1, -90, 0, 16),
		BackgroundTransparency = 1,
		Text = nm,
		Font = F,
		TextSize = 14,
		TextColor3 = T.Sub,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = rw,
	})

	local vlb = New("TextLabel", {
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, -15, 0, 8),
		Size = UDim2.new(0, 70, 0, 16),
		BackgroundTransparency = 1,
		Text = tostring(vl) .. sf,
		Font = F,
		TextSize = 14,
		TextColor3 = T.Txt,
		TextXAlignment = Enum.TextXAlignment.Right,
		Parent = rw,
	})

	local tr = New("Frame", {
		Position = UDim2.new(0, 15, 0, 31),
		Size = UDim2.new(1, -30, 0, 5),
		BackgroundColor3 = T.Off,
		BorderSizePixel = 0,
		Parent = rw,
	}, {Crn(3)})

	local fi = New("Frame", {
		Size = UDim2.new(0, 0, 1, 0),
		BackgroundColor3 = T.Acc,
		BorderSizePixel = 0,
		Parent = tr,
	}, {Crn(3)})

	local kn = New("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0, 0, 0.5, 0),
		Size = UDim2.new(0, 12, 0, 12),
		BackgroundColor3 = Color3.new(1, 1, 1),
		BorderSizePixel = 0,
		Parent = tr,
	}, {Crn(6)})

	local el = {
		Type = "Slider",
		Name = nm,
		Flag = fl,
		Row = rw,
		Value = vl,
		Callback = cb,
	}

	local function setV(v, sl)
		v = math.clamp(v, mn, mx)
		if st > 0 then
			v = math.floor((v - mn) / st + 0.5) * st + mn
		end
		v = math.clamp(v, mn, mx)
		v = tonumber(string.format("%.4f", v))

		el.Value = v
		Lib.Flags[fl] = v

		local rl = (v - mn) / (mx - mn)
		Twn(fi, {Size = UDim2.new(rl, 0, 1, 0)}, 0.08)
		Twn(kn, {Position = UDim2.new(rl, 0, 0.5, 0)}, 0.08)
		vlb.Text = tostring(v) .. sf

		if not sl then
			cb(v)
		end
	end

	function el:Set(v, sl)
		setV(v, sl)
	end

	local dg = false
	local function upd(i)
		local rl = math.clamp((i.Position.X - tr.AbsolutePosition.X) / tr.AbsoluteSize.X, 0, 1)
		setV(mn + (mx - mn) * rl)
	end

	tr.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
			dg = true
			upd(i)
			local mv, en
			mv = UIS.InputChanged:Connect(function(x)
				if dg and (x.UserInputType == Enum.UserInputType.MouseMovement or x.UserInputType == Enum.UserInputType.Touch) then
					upd(x)
				end
			end)
			en = UIS.InputEnded:Connect(function(x)
				if x.UserInputType == Enum.UserInputType.MouseButton1 or x.UserInputType == Enum.UserInputType.Touch then
					dg = false
					mv:Disconnect()
					en:Disconnect()
				end
			end)
		end
	end)

	setV(vl, true)
	self:AddRow(rw)
	self:_AddEl(el)
	return el
end

function Sec:CreateTextBox(cfg)
	cfg = cfg or {}
	local nm = cfg.Name or "Input"
	local fl = cfg.Flag or nm
	local df = cfg.Default or ""
	local cb = cfg.Callback or function() end

	local rw = New("Frame", {
		Size = UDim2.new(1, 0, 0, 50),
		BackgroundTransparency = 1,
	})

	New("TextLabel", {
		Position = UDim2.new(0, 15, 0, 8),
		Size = UDim2.new(1, -30, 0, 14),
		BackgroundTransparency = 1,
		Text = nm,
		Font = F,
		TextSize = 14,
		TextColor3 = T.Sub,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = rw,
	})

	local bx = New("Frame", {
		Position = UDim2.new(0, 15, 0, 26),
		Size = UDim2.new(1, -30, 0, 22),
		BackgroundColor3 = T.El,
		BorderSizePixel = 0,
		Parent = rw,
	}, {Crn(5)})

	local tb = New("TextBox", {
		Position = UDim2.new(0, 8, 0, 0),
		Size = UDim2.new(1, -16, 1, 0),
		BackgroundTransparency = 1,
		Text = df,
		PlaceholderText = cfg.Placeholder or "...",
		PlaceholderColor3 = T.Sub,
		Font = F,
		TextSize = 13,
		TextColor3 = T.Txt,
		TextXAlignment = Enum.TextXAlignment.Left,
		ClearTextOnFocus = false,
		Parent = bx,
	})

	local el = {
		Type = "TextBox",
		Name = nm,
		Flag = fl,
		Row = rw,
		Value = df,
		Callback = cb,
	}

	tb.FocusLost:Connect(function()
		el.Value = tb.Text
		Lib.Flags[fl] = tb.Text
		cb(tb.Text)
	end)

	self:AddRow(rw)
	self:_AddEl(el)
	return el
end

function Sec:CreateDropdown(cfg)
	cfg = cfg or {}
	local nm = cfg.Name or "Dropdown"
	local fl = cfg.Flag or nm
	local op = cfg.Options or {}
	local cb = cfg.Callback or function() end
	local cu = cfg.Default or (op[1] or "None")

	local rw = New("Frame", {
		Size = UDim2.new(1, 0, 0, 34),
		BackgroundTransparency = 1,
	})

	New("TextLabel", {
		Position = UDim2.new(0, 15, 0, 0),
		Size = UDim2.new(1, -130, 1, 0),
		BackgroundTransparency = 1,
		Text = nm,
		Font = F,
		TextSize = 14,
		TextColor3 = T.Sub,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = rw,
	})

	local vlb = New("TextLabel", {
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -15, 0.5, 0),
		Size = UDim2.new(0, 110, 0, 16),
		BackgroundTransparency = 1,
		Text = tostring(cu),
		Font = F,
		TextSize = 14,
		TextColor3 = T.Txt,
		TextXAlignment = Enum.TextXAlignment.Right,
		Parent = rw,
	})

	local li = New("Frame", {
		Position = UDim2.new(0, 15, 0, 34),
		Size = UDim2.new(1, -30, 0, 0),
		BackgroundColor3 = T.El,
		BorderSizePixel = 0,
		Visible = false,
		ClipsDescendants = true,
		Parent = rw,
	}, {
		Crn(6),
		New("UIListLayout", {SortOrder = Enum.SortOrder.LayoutOrder}),
	})

	local open = false
	local opb = {}

	local el = {
		Type = "Dropdown",
		Name = nm,
		Flag = fl,
		Row = rw,
		Value = cu,
		Callback = cb,
	}

	local function setO(s)
		open = s
		li.Visible = s
		li.Size = UDim2.new(1, -30, 0, s and #op * 26 or 0)
		rw.Size = UDim2.new(1, 0, 0, 34 + (s and #op * 26 or 0))
	end

	local function setV(v, sl)
		el.Value = v
		Lib.Flags[fl] = v
		vlb.Text = tostring(v)
		for o, bt in pairs(opb) do
			Twn(bt, {TextColor3 = (o == v) and T.Acc or T.Txt})
		end
		if not sl then
			cb(v)
		end
	end

	function el:Set(v, sl)
		setV(v, sl)
	end

	for i, o in ipairs(op) do
		local ob = New("TextButton", {
			Size = UDim2.new(1, 0, 0, 26),
			BackgroundTransparency = 1,
			Text = "  " .. tostring(o),
			Font = F,
			TextSize = 13,
			TextColor3 = T.Txt,
			TextXAlignment = Enum.TextXAlignment.Left,
			AutoButtonColor = false,
			LayoutOrder = i,
			Parent = li,
		})
		ob.MouseEnter:Connect(function()
			Twn(ob, {BackgroundTransparency = 0.85, BackgroundColor3 = T.Divide})
		end)
		ob.MouseLeave:Connect(function()
			Twn(ob, {BackgroundTransparency = 1})
		end)
		ob.MouseButton1Click:Connect(function()
			setV(o)
			setO(false)
		end)
		opb[o] = ob
	end

	local hd = New("TextButton", {
		Size = UDim2.new(1, 0, 0, 34),
		BackgroundTransparency = 1,
		Text = "",
		Parent = rw,
	})
	hd.MouseButton1Click:Connect(function()
		setO(not open)
	end)

	setV(cu, true)
	self:AddRow(rw)
	self:_AddEl(el)
	return el
end

return Lib
