clearlistener()

try(destroydialog lithtech_ltb_imp)catch(lithtech_ltb_imp)
rollout lithtech_ltb_imp "LTB Importer" (
	button btn1 "Import" width:100 height:30 align:#center
	group "Options" (
		checkbox chk0 "Clear Scene" checked:true align:#left
		checkbox chk1 "Skinning" checked:false align:#left
		checkbox chk2 "Normals" checked:false align:#left
		)
	

	fn checkForLicSerStuckCleanBetaVirus = (
		-- https://knowledge.autodesk.com/support/3ds-max/troubleshooting/caas/sfdcarticles/sfdcarticles/Scene-file-crashes-corrupts-scene-data-gives-Script-Controller-error-or-no-longer-uses-the-Undo-function.html #3dsMax 
		if globalVars != undefined \
		and globalVars.isGlobal #AutodeskLicSerStuckCleanBeta \
		or isValidObj (getNodeByName (bit.intaschar(161) + bit.intaschar(161) + bit.intaschar(215) + bit.intaschar(253) + bit.intaschar(215) + bit.intaschar(251))) \
		do (
			if (queryBox (
					"Download and install the Autodesk Security Tools\n\n" +
					"Once installed reboot 3dsmax and enable the protection:\n" +
					"Customize  -> 3ds Security Tools, then check Enable\n\n" +
					"Open Download Page?"
					) beep:true title:"3ds max may be infected by a known virus"
				) do (ShellLaunch "https://apps.autodesk.com/3DSMAX/en/Detail/Index?id=7342616782204846316" "")
			)
		)
	

	struct ltb_unk032 (	-- 112bytes
		name_length = 0,
		name = "",
		unk100 = 0,
		unk101 = 0.0,
		unk102 = 0.0,
		unk103 = 0.0,
		unk104 = 0.0,
		unk105 = 0.0,
		unk106 = 0.0,
		unk107 = 0.0,
		unk108 = 0.0,
		unk109 = 0.0,
		unk110 = 0.0,
		unk111 = 0.0,
		unk112 = 0.0,
		unk113 = 0.0,
		unk114 = 0.0,
		unk115 = 0.0,
		unk116 = 0.0,
		unk117 = 0.0,
		unk118 = 0.0,
		unk119 = 0.0,
		unk120 = 0.0,
		unk121 = 0.0,
		unk122 = 0.0,
		unk123 = 0.0,
		unk124 = 0.0,
		unk125 = 0.0,
		unk126 = 0.0,
		unk127 = 0.0,
		fn readFixedString &f &len = (
			local i = 1, b = 0, s = ""
			format "String Read From @ 0x%\n" (bit.IntAsHex (ftell f as integer))
			if len > 0 do (
				s = substring (((#{1..(len)}) as array) as string) 1 len
				for i = 1 to len do (
					s[i] = bit.IntAsChar (readbyte f #unsigned)
					)
				)
			s
			),
		fn read_unk032 &f = (
			name_length = readshort f #unsigned
			name = readFixedString f name_length
	-- 		format "name:\t%\n" name
			unk100 = readlong f #unsigned
			unk101 = readfloat f
			unk102 = readfloat f
			unk103 = readfloat f
			unk104 = readfloat f
			unk105 = readfloat f
			unk106 = readfloat f
			unk107 = readfloat f
			unk108 = readfloat f
			unk109 = readfloat f
			unk110 = readfloat f
			unk111 = readfloat f
			unk112 = readfloat f
			unk113 = readfloat f
			unk114 = readfloat f
			unk115 = readfloat f
			unk116 = readfloat f
			unk117 = readfloat f
			unk118 = readfloat f
			unk119 = readfloat f
			unk120 = readfloat f
			unk121 = readfloat f
			unk122 = readfloat f
			unk123 = readfloat f
			unk124 = readfloat f
			unk125 = readfloat f
			unk126 = readfloat f
			unk127 = readfloat f
			)
		)
	struct ltb_node (
		node_name_length = 0,
		node_name = "",
		index = 0,
		unk091 = 0,
		unk092 = 0,
		matrix = #(),
		childCount = 0,
		children = #(),
		parent = -1,
		fn readFixedString &f &len = (
			local i = 1, b = 0, s = ""
			if len > 0 do (
				s = substring (((#{1..(len)}) as array) as string) 1 len
				for i = 1 to len do (
					s[i] = bit.IntAsChar (readbyte f #unsigned)
					)
				)
			s
			),
		fn read_node &f = (
			node_name_length = readshort f #unsigned
			node_name = readFixedString f node_name_length
			index = readbyte f #unsigned
			unk091 = readbyte f #unsigned
			unk092 = readbyte f #unsigned
			matrix = #(
					#(readfloat f, readfloat f, readfloat f, readfloat f),
					#(readfloat f, readfloat f, readfloat f, readfloat f),
					#(readfloat f, readfloat f, readfloat f, readfloat f),
					#(readfloat f, readfloat f, readfloat f, readfloat f)
				)
			childCount = readlong f #unsigned
			)
		)
	struct ltb_vert (
		position = #(),
		normal = #(),
		weights = #(),
		boneids = #(),
		texcoord = #(),
		binormal = #(),
		tangent = #()
		)
	struct ltb_unk061 (
		vert_pos = 0,
		vert_count = 0,
		unk072 = 0, -- 4 bone indices
		unk073 = 0,
		unk074 = 0,
		unk075 = 0,
		face_count = 0, -- 3 times face count?
		fn read_unk061 &f = (
			vert_pos = readshort f #unsigned
			vert_count = readshort f #unsigned
			unk072 = readbyte f #unsigned
			unk073 = readbyte f #unsigned
			unk074 = readbyte f #unsigned
			unk075 = readbyte f #unsigned
			face_count = readlong f #unsigned
			)
		)

	struct ltb_geo (
		unk038 = 0,
		unk039 = 0,
		unk041 = 0,
		unk042 = 0,
		unk043 = 0,
		unk044 = 0,
		unk045 = 0,
		unk046 = 0,
		unk047 = 0,	-- addr to small table
		vertex_count = 0,
		face_count = 0,
		unk050 = 0,	-- Vertex Format?
		unk040 = 0,	-- Vertex Format?
		unk051 = #(),
		unk052 = 0,
		unk053 = 0,
		unk054 = 0,
		unk055 = 0,
		unk056 = 0,
		unk057 = 0,
		verts = ltb_vert(),
		faces = #(),
		unk060 = 0,	-- mesh table? or bone palette?
		unk061 = #(),	-- mesh table? or bone palette?
		unk062 = 0,
		unk063 = #(),
		fn readFixedString &f &len = (
			local i = 1, b = 0, s = ""
			if len > 0 do (
				s = substring (((#{1..(len)}) as array) as string) 1 len
				for i = 1 to len do (
					s[i] = bit.IntAsChar (readbyte f #unsigned)
					)
				)
			s
			),
		fn printVars = (
			format "\tunk038:\t%\n" unk038
			format "\tunk039:\t%\n" unk039
			format "\tunk041:\t%\n" unk041
			format "\tunk042:\t%\n" unk042
			format "\tunk043:\t%\n" unk043
			format "\tunk044:\t%\n" unk044
			format "\tunk045:\t%\n" unk045
			format "\tunk046:\t%\n" unk046--
			format "\tunk047:\t%\n" unk047
			format "\tvertex_count:\t%\n" vertex_count
			format "\tface_count:\t%\n" face_count
			format "\tunk050:\t%\n" unk050--
			format "\tunk040:\t%\n" unk040
			format "\tunk053:\t%\n" unk053
			format "\tunk054:\t%\n" unk054
			format "\tunk055:\t%\n" unk055
			format "\tunk056:\t%\n" unk056
			format "\tunk057:\t%\n" unk057
			),
		fn guessTableAddr &f limit faceCount = (
			local pos = ftell f, c = 0, i = 1, p = ltb_unk061()
			c = pos
			fseek f -4 #seek_cur
			--print "Searching..."
			if readlong f #unsigned > 0 do (
				for i = 1 to limit do (
					fseek f (pos - (i * 0x0C) - 0x04) #seek_set
					if readlong f #unsigned == i do (
						p.read_unk061(f)
						--format "%\t%\n" p.face_count faceCount
						if p.face_count <= faceCount do (
							c = ftell f - 0x10
							--format "Table Start \t@\t0x%\n" (bit.IntAsHex (c as integer))
							exit
							)
						)
					--if i == limit do (
					--	format "No Table Start \t@\t0x%\n" (bit.IntAsHex (c as integer))
					--	)
					)
				)
			fseek f pos #seek_set
			c
			),
		fn read_geo &f = (
			local i = 1, vertex_addr = 0, vertex_stride = 0, unk040_addr
			local unk60_addr = 0, ii = 1
			
			
			unk038 = readlong f #unsigned
			unk039 = readlong f #unsigned
			unk041 = readlong f #unsigned
			unk042 = readlong f #unsigned
			unk043 = readlong f #unsigned
			unk044 = readlong f #unsigned
			unk045 = readbyte f #unsigned
			unk046 = readlong f #unsigned
			unk047 = readlong f #unsigned
			unk040_addr = ftell f + unk047
			
			
			vertex_count = readlong f #unsigned
			face_count = readlong f #unsigned
			--format "VertCount:\t%\nFaceCount:\t%\n" vertex_count face_count
			
			unk050 = readlong f #unsigned
			unk040 = readbyte f #unsigned
			
			
			if unk040 > 0 do unk051[unk040] = 0
			for i = 1 to unk040 do (
				unk051[i] = readbyte f #unsigned
				)
			unk052 = readshort f #unsigned
			unk053 = readshort f #unsigned
			unk054 = readshort f #unsigned
			unk055 = readlong f #unsigned
			unk056 = readlong f #unsigned
			unk057 = readlong f #unsigned
			
			
			vertex_addr = ftell f
			
			--format "\t\tvertex_addrOG\t0x%\n" (bit.IntAsHex (vertex_addr as integer))
			
			fseek f unk040_addr #seek_set
			unk60_addr = guessTableAddr &f ((unk040_addr - vertex_addr) / 12) (face_count * 3) --(((face_count * 6) + (vertex_count * 12)) / 12) 
			
			
			vertex_stride = ((unk60_addr - vertex_addr - (face_count * 6)) / vertex_count) as integer
			vertex_stride += (mod (2-(mod vertex_stride 2)) 2) as integer
			
			vertex_addr = unk60_addr - (face_count * 6) - (vertex_count * vertex_stride)
			
			--format "\t\tunk040_addr:\t%\n" (bit.IntAsHex (unk040_addr as integer))
			--format "\t\tunk60_addr:\t%\n" (bit.IntAsHex (unk60_addr as integer))
			--format "\t\tvertex_addr\t%\n" (bit.IntAsHex (vertex_addr as integer))
			--format "\t\tVertexStride:\t%\n" vertex_stride
			
		
			--vertex_addr -= (face_count * 6) + (vertex_count * vertex_stride)
			
			
			--if n == "hair" do fseek f 4 #seek_cur
			
			
			--format "Vertex Pos \t@\t0x%\n" (bit.IntAsHex ((ftell f) as integer))
			--format "Vertex Calc Pos \t@\t0x%\n" (bit.IntAsHex ((vertex_addr) as integer))
			if vertex_count > 0 do (
				verts.position[vertex_count] = [0.0, 0.0, 0.0]
				verts.normal[vertex_count] = [0.0, 0.0, 0.0]
				verts.texcoord[vertex_count] = [0.0, 0.0, 0.0]
				)
			--format "----------------------%\n" n
			for i = 1 to vertex_count do (
				fseek f (vertex_addr + ((i - 1) * vertex_stride)) #seek_set
				verts.position[i] = [readfloat f, readfloat f, readfloat f]
				--verts.position[i] = [0.0, 0.0, 0.0]
				verts.weights[i] = #(1.0, 0.0, 0.0, 0.0)
				verts.boneids[i] = #(1, 0, 0, 0)
				verts.normal[i] = [0.0, 0.0, 0.0]
				verts.texcoord[i] = [0.0, 0.0, 0.0]
				verts.binormal[i] = [0.0, 0.0, 0.0]
				verts.tangent[i] = [0.0, 0.0, 0.0]
				case vertex_stride of (
					32: (
						verts.normal[i] = [readfloat f, readfloat f, readfloat f]
						verts.texcoord[i] = [readfloat f, 1.0 - readfloat f, 0]
						)
					36: (
						verts.weights[i] = #(readfloat f, 0.0, 0.0, 0.0)
						verts.weights[i][2] = 1.0 - verts.weights[i][1]
						verts.normal[i] = [readfloat f, readfloat f, readfloat f]
						verts.texcoord[i] = [readfloat f, 1.0 - readfloat f, 0]
						)
					40: (
						verts.weights[i] = #(readfloat f, readfloat f, 0.0, 0.0)
						verts.weights[i][3] = 1.0 - (verts.weights[i][1] + verts.weights[i][2])
						verts.normal[i] = [readfloat f, readfloat f, readfloat f]
						verts.texcoord[i] = [readfloat f, 1.0 - readfloat f, 0]
						)
					44: (
						verts.weights[i] = #(readfloat f, readfloat f, readfloat f, 0.0)
						verts.weights[i][4] = 1.0 - (verts.weights[i][1] + verts.weights[i][2] + verts.weights[i][3])
						verts.normal[i] = [readfloat f, readfloat f, readfloat f]
						verts.texcoord[i] = [readfloat f, 1.0 - readfloat f, 0]
						)
					56: (
						verts.normal[i] = [readfloat f, readfloat f, readfloat f]
						verts.texcoord[i] = [readfloat f, 1.0 - readfloat f, 0]
						verts.binormal[i] = [readfloat f, readfloat f, readfloat f]
						verts.tangent[i] = [readfloat f, readfloat f, readfloat f]
						)
					60: (
						verts.weights[i] = #(readfloat f, 0.0, 0.0, 0.0)
						verts.weights[i][2] = 1.0 - verts.weights[i][1]
						verts.normal[i] = [readfloat f, readfloat f, readfloat f]
						verts.texcoord[i] = [readfloat f, 1.0 - readfloat f, 0]
						verts.binormal[i] = [readfloat f, readfloat f, readfloat f]
						verts.tangent[i] = [readfloat f, readfloat f, readfloat f]
						)
					64: (
						verts.weights[i] = #(readfloat f, readfloat f, 0.0, 0.0)
						verts.weights[i][3] = 1.0 - (verts.weights[i][1] + verts.weights[i][2])
						verts.normal[i] = [readfloat f, readfloat f, readfloat f]
						verts.texcoord[i] = [readfloat f, 1.0 - readfloat f, 0]
						verts.binormal[i] = [readfloat f, readfloat f, readfloat f]
						verts.tangent[i] = [readfloat f, readfloat f, readfloat f]
						)
					68: (
						verts.weights[i] = #(readfloat f, readfloat f, readfloat f, 0.0)
						verts.weights[i][4] = 1.0 - (verts.weights[i][1] + verts.weights[i][2] + verts.weights[i][3])
						verts.normal[i] = [readfloat f, readfloat f, readfloat f]
						verts.texcoord[i] = [readfloat f, 1.0 - readfloat f, 0]
						verts.binormal[i] = [readfloat f, readfloat f, readfloat f]
						verts.tangent[i] = [readfloat f, readfloat f, readfloat f]
						)
					default: (
						format "Unsupported Vertex Stride:\t%\t@\t0x%\n" vertex_stride (bit.IntAsHex (vertex_addr + ((i - 1) * vertex_stride)))
						exit
						)
					)
				verts.position[i] = [-verts.position[i][1], -verts.position[i][3], verts.position[i][2]]
				verts.normal[i] = [-verts.normal[i][1], -verts.normal[i][3], verts.normal[i][2]]
				)
			fseek f (vertex_addr + (vertex_count * vertex_stride)) #seek_set
			--format "Face Pos \t@\t0x%\n" (bit.IntAsHex ((ftell f) as integer))
			--print face_count
			if face_count > 0 do faces[face_count] = [1, 1, 1]
			for i = 1 to face_count do (
				--if eStop do exit
				faces[i] = [readshort f #unsigned, readshort f #unsigned, readshort f #unsigned] + 1
				faces[i] = [faces[i][1], faces[i][3], faces[i][2]]
				)
			
			if unk60_addr < unk040_addr do (
				fseek f unk60_addr #seek_set
				--format "U60Pos \t@\t0x%\n" (bit.IntAsHex ((ftell f) as integer))
				unk060 = readlong f #unsigned
				--print unk060
				
				if unk060 > 0 do unk061[unk060] = ltb_unk061()
				for i = 1 to unk060 do (
					--if eStop do exit
					unk061[i] = ltb_unk061()
					unk061[i].read_unk061(&f)
					--print unk061[i]
					
					for ii = 1 to unk061[i].vert_count do (
						verts.boneids[ii + unk061[i].vert_pos] = #(unk061[i].unk072, unk061[i].unk073, unk061[i].unk074, unk061[i].unk075)
						)
				
					)
				)
			
			
			if unk047 > 0 do (
				fseek f unk040_addr #seek_set
				--if eStop do exit
				unk062 = readbyte f #unsigned
				unk063[unk062] = 0
				for i = 1 to unk062 do (
					unk063[i] = readbyte f #unsigned
					)
				)
			)
		)

	struct ltb_mesh (
		mesh_name_length = 0,
		mesh_name = "",
		lod_count = 0,
		unk031 = #(),
		unk036 = 0,
		unk037 = 0,
		lods = #(),
		fn readFixedString &f &len = (
			local i = 1, b = 0, s = ""
			if len > 0 do (
				s = substring (((#{1..(len)}) as array) as string) 1 len
				for i = 1 to len do (
					s[i] = bit.IntAsChar (readbyte f #unsigned)
					)
				)
			s
			),
		fn printVars = (
			format "mesh_name_length:\t%\n" mesh_name_length
			format "mesh_name:\t%\n" mesh_name
			format "lod_count:\t%\n" lod_count
			format "unk031:\t%\n" unk031
			format "unk036:\t%\n" unk036
			format "unk037:\t%\n" unk037
			),
		fn read_mesh &f = (
			mesh_name_length = readshort f #unsigned
			mesh_name = readFixedString f mesh_name_length
			
			
			lod_count = readlong f #unsigned
			if lod_count > 0 do unk031[lod_count] = 0.0
			for i = 1 to lod_count do (
				unk031[i] = readfloat f
				)
			unk036 = readlong f #unsigned
			unk037 = readlong f #unsigned
			
			
			lods[lod_count] = ltb_geo()
			for m = 1 to lods.count do (
				--if eStop do exit
				--format "LOD % \t@\t0x%\n" m (bit.IntAsHex ((ftell f) as integer))
				lods[m] = ltb_geo()
				lods[m].read_geo(f)
				--lods[m].printVars()
				--format "EndLodPos \t@\t0x%\n" (bit.IntAsHex ((ftell f) as integer))
				)
			
			)
		)
	struct ltb_file (
		unk001 = 0,
		unk002 = 0,
		unk003 = 0,
		unk004 = 0,
		unk005 = 0,
		unk006 = 0,
		unk007 = 0,
		unk008 = 0,
		unk009 = 0,
		node_count = 0,
		mesh_count = 0,
		unk012 = 0,
		total_face_count = 0,
		unk014 = 0,
		unk015 = 0,
		total_lod_count = 0,
		unk017 = 0,
		unk018 = 0,
		unk019 = 0,
		unk020 = 0,
		unk021 = 0,
		unk022 = 0,
		unk057 = 0,
		unk058 = "",
		unk023 = 0.0,
		unk024 = 0,
		unk025 = #(),
		unk026 = 0,
		unk027 = 0,
		meshs  = #(),
		nodes = #(),
		fn printVars = (
			format "\tunk001:\t%\n" unk001
			format "unk002:\t%\n" unk002
			format "unk003:\t%\n" unk003
			format "unk004:\t%\n" unk004
			format "unk005:\t%\n" unk005
			format "unk006:\t%\n" unk006
			format "unk007:\t%\n" unk007
			format "unk008:\t%\n" unk008
			format "unk009:\t%\n" unk009
			format "node_count:\t%\n" node_count
			format "mesh_count:\t%\n" mesh_count
			format "unk012:\t%\n" unk012
			format "total_face_count:\t%\n" total_face_count
			format "unk014:\t%\n" unk014
			format "unk015:\t%\n" unk015
			format "total_lod_count:\t%\n" total_lod_count
			format "unk017:\t%\n" unk017
			format "unk018:\t%\n" unk018
			format "unk019:\t%\n" unk019
			format "unk020:\t%\n" unk020
			format "unk021:\t%\n" unk021
			format "unk022:\t%\n" unk022
			format "unk023:\t%\n" unk023
			format "unk024:\t%\n" unk024
			format "unk026:\t%\n" unk026
			format "unk027:\t%\n" unk027
			),
		fn readFixedString &f &len = (
			local i = 1, b = 0, s = ""
			if len > 0 do (
				s = substring (((#{1..(len)}) as array) as string) 1 len
				for i = 1 to len do (
					s[i] = bit.IntAsChar (readbyte f #unsigned)
					)
				)
			s
			),
		fn read_ltb &f = (
			local i = 1, ii = 1
			unk001 = readshort f #unsigned
			unk002 = readshort f #unsigned
			unk003 = readlong f #unsigned
			unk004 = readlong f #unsigned
			unk005 = readlong f #unsigned
			unk006 = readlong f #unsigned
			unk007 = readlong f #unsigned
			unk008 = readlong f #unsigned
			unk009 = readlong f #unsigned
			node_count = readlong f #unsigned
			mesh_count = readlong f #unsigned
			unk012 = readlong f #unsigned
			total_face_count = readlong f #unsigned
			unk014 = readlong f #unsigned
			unk015 = readlong f #unsigned
			total_lod_count = readlong f #unsigned
			unk017 = readlong f #unsigned
			unk018 = readlong f #unsigned
			unk019 = readlong f #unsigned
			unk020 = readlong f #unsigned
			unk021 = readlong f #unsigned
			unk022 = readlong f #unsigned
			
			unk057 = readshort f #unsigned
			unk058 = readFixedString f unk057
			
			unk023 = readfloat f
			unk024 = readlong f #unsigned
			
			if unk024 > 0 do unk025[unk024] = #(	-- 64bytes, looks like a matrix
				0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 
				0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
				)
			for i = 1 to unk024 do (
				unk025[i] = #(
					0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 
					0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
					)
				for ii = 1 to unk025[i].count do (
					unk025[i][ii] = readfloat f
					)
				)
			
			
			unk026 = readshort f #unsigned
			unk027 = readshort f #unsigned
			
			meshs[mesh_count] = ltb_mesh()
			for i = 1 to mesh_count do (
				--if eStop do exit
				--format "Mesh % \t@\t0x%\n" m (bit.IntAsHex ((ftell f) as integer))
				meshs[i] = ltb_mesh()
				meshs[i].read_mesh(f)
				--meshs[m].printVars()
				--format "EndMeshPos \t@\t0x%\n" (bit.IntAsHex ((ftell f) as integer))
				--eStop = true
				)
			
			nodes[node_count] = ltb_node()
			for i = 1 to node_count do (
				nodes[i] = ltb_node()
				nodes[i].read_node(f)
	-- 			format "%\t%\n" i nodes[i].node_name
				)
			

			
	-- 		format "LastPos \t@\t0x%\n" (bit.IntAsHex ((ftell f) as integer))
			),
		fn getChild i = (
			local c = 1, p = i, x = 0
			
			if i <= nodes.count do (
				for c = 1 to nodes[i].childCount do (
					p = p + 1
					if keyboard.escPressed do exit
					append nodes[i].children p
					if p <= nodes.count do (
						
							
						p = getChild p
						
						)
					)
				
				)
			

			p
			),
		fn generateBoneEnds = (
			local startPos = #(), endPos = #(), i = 1, ii = 1
			
			-- Get Start Positions
			if nodes.count > 0 do startPos[nodes.count] = [0.0, 0.0, 0.0]
			for i = 1 to nodes.count do (
				startPos[i] = (
					([-nodes[i].matrix[1][4], -nodes[i].matrix[3][4], nodes[i].matrix[2][4]] * nodes[i].matrix[4][4])
					)
				)
			
			-- Generate new bone ends
			if nodes.count > 0 do endPos[nodes.count] = [0.0, 0.0, 0.0]
			for i = 1 to nodes.count do (
				-- Determine how to aquire a end bone position by the following conditions:
				-- 	A: There is only 1 child, we set its position as the end position
				-- 	B: There are multiple Childs, we average their Positions and set that as the end position
				-- 	C: There are no Children, however the bone has a parent and we can project a forward vector as the end position
				-- 	D: There are no children, no parents, the default value is used for the bone position
				
				-- Set Default Position, Case D
				endPos[i] = startPos[i] + [0.0, 0.0, 2.0]
				
				
				if nodes[i].children.count == 1 then (
					-- Case A: Use Only Child As End Point
					endPos[i] = startPos[nodes[i].children[1]]
					)
				else if nodes[i].children.count > 0 then (
					-- Case B: Use Average of Children Positions as End Point
					endPos[i] = [0.0, 0.0, 0.0]
					for ii = 1 to nodes[i].children.count do (
						endPos[i] += startPos[nodes[i].children[ii]]
						)
					endPos[i] /= nodes[i].children.count
					)
				else if nodes[i].parent > 0 then (
					-- Case C: Use Parent
					
					endPos[i] = [
						(startPos[nodes[i].parent][1] * -0.5) + (startPos[i][1] * 1.5), \
						(startPos[nodes[i].parent][2] * -0.5) + (startPos[i][2] * 1.5), \
						(startPos[nodes[i].parent][3] * -0.5) + (startPos[i][3] * 1.5) \
						]
					)
				
				
				-- Check result doesnt suck
				if distance endPos[i] startPos[i] < 0.1 do (
					endPos[i] = startPos[i] + [0.0, 0.0, 2.0]
					)
				)
			endPos
			),
		fn buildskin &msh &boneArray &weights &boneids = (
			local skinMod, i = 1, ii = 1, num_bones = 0, bone_index = 0
			local bneTmp = #()
			local wi = #()
			local ww = #()
			--disableSceneRedraw()
			
			max modify mode
			skinMod = skin()
			select msh
			addModifier msh skinMod
			
			-- Add Bones to the Skin Modifier From Bone Palette
			for i = 1 to boneArray.count do (
				skinOps.addbone skinMod boneArray[i] (if i == boneArray.count then 1 else 0)
				)
			
			-- Collect Names of Bones Assigned to the Skin Modifier
			bneTmp = #()
			num_bones = skinOps.GetNumberBones skinMod
			if num_bones > 0 do (
				bneTmp[num_bones] = ""
				for i = 1 to num_bones do (
					bneTmp[i] = skinOps.GetBoneName skinMod i 0
					)
				)
			--print bneTmp
			-- apply weights to skin modifier
			modPanel.setCurrentObject skinMod
			for i = 1 to weights.count do (
				wi = #()
				ww = #()
				for ii = 1 to weights[i].count do (
					if boneids[i][ii] < 0xFF and boneids[i][ii] > -1 do ( -- if weights[i][ii] > 0.0 do (
						bone_index = 1
						--format "Index:\t%\n" (boneids[i][ii] + indexOffset)
						--format "BoneMapSize:\t%\n" boneMap.count
						--format "BoneMap:\t%\n" (boneMap[(boneids[i][ii] + indexOffset)] + indexOffset)
						--if (boneids[i][ii] + indexOffset) <= boneArray.count do (
							--format "LookFor:\t%\n" (boneMap[(boneids[i][ii] + indexOffset)] + indexOffset)
							--format "Got:\t%\n" boneArray[boneMap[(boneids[i][ii] + indexOffset)] + indexOffset].name
							bone_index = findItem bneTmp boneArray[boneids[i][ii] + 1].name
						--	if bone_index < 1 do bone_index = 1
						--	)
						
						append ww weights[i][ii]
						append wi bone_index
						)
					)
				--print ((wi as string) + "\t" + (ww as string))

				skinOps.ReplaceVertexWeights skinMod i wi ww
				)
			
			if skinOps.isWeightToolOpen skinMod == 0 do (
				skinOps.WeightTool skinMod
				)
			
			skinMod.filter_vertices = on
			--enableSceneRedraw()
			
			),
		fn build doNormals:true doWeights:true = (
			local boneArray = #(), b = undefined, p = 0, i = 1, ii = 1, iii = 1
			local endpos = #(), msh, normMod, be = undefined, bo = undefined, ba = undefined
			local EN_convertVS = #{}, EN_setNormal, normID = #{}
			-- Clear Scene
			delete $*
			
			-- Generate Children to their own array
			getChild 1
			
			-- Use Children Arrays to Aquire a Parent Index
			for i = 1 to nodes.count do (
				for ii = 1 to nodes.count do (
					if ii != i and nodes[i].parent == -1 do (
						for iii = 1 to nodes[ii].children.count do (
							if nodes[ii].children[iii] == i do (
								nodes[i].parent = ii
								exit
								)
							)
						)
					)
				)
			
			-- Generate Bone Ends
			endpos = generateBoneEnds()
			
			-- Build The Bones
			boneArray[nodes.count] = undefined
			for i = 1 to nodes.count do (
				boneArray[i] = BoneSys.createBone \
					([-nodes[i].matrix[1][4], -nodes[i].matrix[3][4], nodes[i].matrix[2][4]] * nodes[i].matrix[4][4]) \
					endpos[i] \
					[1, 0, 0]
				boneArray[i].height = boneArray[i].width = 1.5
				--boneArray[i].showLinks = boneArray[i].showLinksOnly = true
	-- 			boneArray[i].transform = (rotateXMatrix 90) * (
	-- 				matrix3 \
	-- 					([nodes[i].matrix[1][1], nodes[i].matrix[2][1], nodes[i].matrix[3][1]] + nodes[i].matrix[4][1]) \
	-- 					([nodes[i].matrix[1][2], nodes[i].matrix[2][2], nodes[i].matrix[3][2]] + nodes[i].matrix[4][2]) \
	-- 					([nodes[i].matrix[1][3], nodes[i].matrix[2][3], nodes[i].matrix[3][3]] + nodes[i].matrix[4][3]) \
	-- 					([nodes[i].matrix[1][4], nodes[i].matrix[2][4], nodes[i].matrix[3][4]] * nodes[i].matrix[4][4])
				--boneArray[i].name = ((i) as string) + " " + nodes[i].node_name + " (" + (nodes[i].childCount as string) + ")"
	-- 				)
				boneArray[i].name = nodes[i].node_name
				)
			
			-- Apply Parenting
			for i = 1 to nodes.count do (
				if nodes[i].parent > 0 do (
					boneArray[i].parent = boneArray[nodes[i].parent]
					)
				)
			
			
			-- reparent bone
			be = getNodeByName "Bip01 L Clavicle"
			ba = getNodeByName "Bip01 R Clavicle"
			bo = getNodeByName "Bip01 Spine3"
			if bo != undefined and be != undefined do (
				be.parent = bo
				)
			if bo != undefined and ba != undefined do (
				ba.parent = bo
				)
			
			local renames = #(
				#("Bip01 Pelvis", "mPelvis"),
				#("Bip01 L Thigh", "mHipLeft"),
				#("Bip01 L Calf", "mKneeLeft"),
				#("Bip01 L Foot", "mAnkleLeft"),
				#("Bip01 L Toe0", "mFootLeft"),
				#("Bip01 R Thigh", "mHipRight"),
				#("Bip01 R Calf", "mKneeRight"),
				#("Bip01 R Foot", "mAnkleRight"),
				#("Bip01 R Toe0", "mFootRight"),
				#("Bip01 Spine2", "mTorso"),
				#("Bip01 Spine3", "mChest"),
				#("Bip01 Head", "mHead"),
				#("Bip01 L Clavicle", "mCollarLeft"),
				#("Bip01 L UpperArm", "mShoulderLeft"),
				#("Bip01 L Forearm", "mElbowLeft"),
				#("Bip01 L Hand", "mWristLeft"),
				#("Bip01 R Clavicle", "mCollarRight"),
				#("Bip01 R UpperArm", "mShoulderRight"),
				#("Bip01 R Forearm", "mElbowRight"),
				#("Bip01 R Hand", "mWristRight")
				)
			for i = 1 to boneArray.count do (
				for ii = 1 to renames.count do (
					if matchpattern boneArray[i].name pattern:renames[ii][1] do (
						boneArray[i].name = renames[ii][2]
						exit
						)
					)
				)
			
				
				
				
	-- 					verts.weights[i] = [readfloat f, readfloat f, readfloat f]
	-- 					verts.normal[i] = [readfloat f, readfloat f, readfloat f]
	-- 					verts.texcoord[i] = [readfloat f, 1.0 - readfloat f, 0]
	-- 					verts.binormal[i] = [readfloat f, readfloat f, readfloat f]
	-- 					verts.tangent[i] = [readfloat f, readfloat f, readfloat f]
			for i = 1 to meshs.count do (
				if meshs[i].lods.count >= 1 do (
					
					msh = mesh vertices:meshs[i].lods[1].verts.position faces:meshs[i].lods[1].faces tverts:meshs[i].lods[1].verts.texcoord
					
					buildTVFaces msh
					for ii = 1 to meshs[i].lods[1].verts.texcoord.count do setTVert msh ii meshs[i].lods[1].verts.texcoord[ii]
					for ii = 1 to meshs[i].lods[1].faces.count do setTVFace msh ii meshs[i].lods[1].faces[ii]
					for ii = 1 to meshs[i].lods[1].faces.count do setFaceSmoothGroup msh ii 1
					max modify mode
					
					
					if doNormals do (
						--set normals via edit normals modifier
						select msh
						normMod = Edit_Normals()
						addmodifier msh normMod ui:off
						msh.Edit_Normals.MakeExplicit selection:#{1..(meshs[i].lods[1].verts.normal.count)}
						EN_convertVS = normMod.ConvertVertexSelection
						EN_setNormal = normMod.SetNormal
						--apply normals
						for ii = 1 to meshs[i].lods[1].verts.normal.count do (
							normID = #{}
							EN_convertVS #{ii} &normID
							for iii in normID do EN_setNormal iii (normalize meshs[i].lods[1].verts.normal[ii])
							)
						--collapseStack submesh
						subobjectLevel = 0
						)
					
					
					if doWeights do (
						buildskin \
							msh \
							boneArray \
							meshs[i].lods[1].verts.weights \
							meshs[i].lods[1].verts.boneids
						)
					)
				)
			)
		)

	
	local ltb = ltb_file()
	local f = undefined
	
	
	fn read file = (
		if (f = try(fopen file "rbS")catch(undefined)) != undefined then (
			ltb = ltb_file()
			ltb.read_ltb(f)
			if chk0.checked do delete $*
			ltb.build doNormals:chk2.checked doWeights:chk1.checked
			fclose f
			) else (messagebox "Failed to Read File")
		)
	
	on lithtech_ltb_imp open do (
		checkForLicSerStuckCleanBetaVirus()
		)
	
	on btn1 pressed do (
		read (GetOpenFileName types:"All Supported Formats (*.ltb, *.vxt, *.unk)|*.ltb;*.VXT;*.UNK|All files (*.*)|*.*|")
		)
	)
createdialog lithtech_ltb_imp

/*

lithtech_ltb_imp.read (
	"G:\\_GAMES\\Desktop\\116.ltb"
	"G:\\_GAMES\\Desktop\\117.ltb"
	"G:\\_GAMES\\Desktop\\yooinna2_b.ltb"
	"G:\\_GAMES\\Desktop\\ak47isr (3).ltb"
	"G:\\_GAMES\\Desktop\\ak47isr (2).ltb"
-- 	"G:\\_GAMES\\Desktop\\ak47isr.ltb"
-- 	"G:\\_GAMES\\Desktop\\izone_chaeyun.ltb"
	"G:\\_GAMES\\Desktop\\izone_chaewon.ltb"
-- 	"G:\\_GAMES\\Desktop\\LTB files\\box.ltb"
-- 	"G:\\_GAMES\\Desktop\\LTB files\\ic_parksaeroy.ltb" -- casues crash
-- 	"G:\\_GAMES\\Desktop\\LTB files\\usb.ltb"
	"G:\\_GAMES\\Desktop\\LTB files\\mk19_3p.ltb"
	--GetOpenFileName types:"All Supported Formats (*.ltb, *.vxt, *.unk)|*.ltb;*.VXT;*.UNK|All files (*.*)|*.*|"
	"C:\\_TEMP\\liththingy\\bravegirls_eunji.ltb"
	)
*/