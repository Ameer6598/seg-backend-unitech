<?php

namespace App\Http\Controllers\LensManegment;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\LensManegment\LensTint;
use Illuminate\Support\Facades\Validator;
use App\Models\LensManegment\LensMaterial;
use App\Models\LensManegment\LensProtection;
use App\Models\LensManegment\ScracthCoating;
use App\Models\LensManegment\BlueLightProtection;

class lensManegmentController extends Controller
{


    // lense material 
    public function get($id = null)
    {
        $baseUrl = env('LOGO_URL');

        if ($id) {
            $material = LensMaterial::find($id);

            if (!$material) {
                return response()->json([
                    'status' => false,
                    'message' => 'Material not found',
                ], 404);
            }

            $material->image_url = $baseUrl . $material->image_url;

            return response()->json([
                'status' => true,
                'data' => $material,
            ]);
        }

        $materials = LensMaterial::all();

        // Add base URL to each material's image
        foreach ($materials as $material) {
            $material->image_url = $baseUrl . $material->image_url;
        }

        return response()->json([
            'status' => true,
            'data' => $materials,
        ]);
    }
    public function create(Request $request)
    {

        $validator = Validator::make($request->all(), [
            'title' => 'required|string|max:255',
            'sub_title' => 'required|string|max:255',
            'image' => 'required|file',
            'price' => 'required|numeric|min:0',
            'description' => 'required|string',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => false,
                'errors' => $validator->errors(),
            ], 422);
        }

        if ($request->hasFile('image')) {
            $file = $request->file('image');
            $originalName = $file->getClientOriginalName();
            $fileName = time() . '_' . preg_replace('/\s+/', '_', $originalName);
            $destinationPath = public_path('projectimages/lensmanegment/material');
            if (!file_exists($destinationPath)) {
                mkdir($destinationPath, 0777, true);
            }

            $file->move($destinationPath, $fileName);

            $imagepath = '/projectimages/lensmanegment/material/' . $fileName;
        }



        $data = LensMaterial::create([
            'title' => $request->title,
            'sub_title' => $request->sub_title,
            'image_url' => $imagepath,
            'price' => $request->price,
            'description' => $request->description,
        ]);


        return response()->json([
            'status' => true,
            'data' => $data,
        ]);
    }

    public function update(Request $request, $id)
    {



        $validator = Validator::make($request->all(), [
            'title' => 'required|string|max:255',
            'sub_title' => 'required|string|max:255',
            'image' => 'nullable|file',
            'price' => 'required|numeric|min:0',
            'description' => 'required|string',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => false,
                'errors' => $validator->errors(),
            ], 422);
        }

        $material = LensMaterial::find($id);

        if (!$material) {
            return response()->json([
                'status' => false,
                'message' => 'Material not found',
            ], 404);
        }

        $imagepath = $material->image_url; // default to existing image

        if ($request->hasFile('image')) {
            $file = $request->file('image');
            $originalName = $file->getClientOriginalName();
            $fileName = time() . '_' . preg_replace('/\s+/', '_', $originalName);
            $destinationPath = public_path('projectimages/lensmanegment/material');
            if (!file_exists($destinationPath)) {
                mkdir($destinationPath, 0777, true);
            }

            $file->move($destinationPath, $fileName);
            $imagepath = '/projectimages/lensmanegment/material/' . $fileName;

            // Delete old image file if exists
            $oldImagePath = public_path($material->image_url);
            if (file_exists($oldImagePath)) {
                unlink($oldImagePath);
            }
        }

        $material->update([
            'title' => $request->title,
            'sub_title' => $request->sub_title,
            'image_url' => $imagepath,
            'price' => $request->price,
            'description' => $request->description,
        ]);

        return response()->json([
            'status' => true,
            'message' => 'Material updated successfully',
            'data' => $material,
        ]);
    }

    public function delete($id)
    {
        $material = LensMaterial::find($id);

        if (!$material) {
            return response()->json([
                'status' => false,
                'message' => 'Material not found',
            ], 404);
        }

        $imagePath = public_path($material->image_url);
        if (file_exists($imagePath)) {
            unlink($imagePath);
        }

        $material->delete();
        return response()->json([
            'status' => true,
            'message' => 'Material deleted successfully',
        ]);
    }


    public function getScratchCoating($id = null)
    {
        $baseUrl = env('LOGO_URL');

        if ($id) {
            $coating = ScracthCoating::find($id);

            if (!$coating) {
                return response()->json([
                    'status' => false,
                    'message' => 'Scratch coating not found',
                ], 404);
            }

            $coating->image_url = $baseUrl . $coating->image_url;

            return response()->json([
                'status' => true,
                'data' => $coating,
            ]);
        }

        $coatings = ScracthCoating::all();

        foreach ($coatings as $coating) {
            $coating->image_url = $baseUrl . $coating->image_url;
        }

        return response()->json([
            'status' => true,
            'data' => $coatings,
        ]);
    }


    public function createScratchCoating(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'title' => 'required|string|max:255',
            'sub_title' => 'required|string|max:255',
            'image' => 'required|file',
            'price' => 'required|numeric|min:0',
            'description' => 'required|string',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => false,
                'errors' => $validator->errors(),
            ], 422);
        }

        if ($request->hasFile('image')) {
            $file = $request->file('image');
            $originalName = $file->getClientOriginalName();
            $fileName = time() . '_' . preg_replace('/\s+/', '_', $originalName);
            $destinationPath = public_path('projectimages/lensmanegment/scratch_coating');
            if (!file_exists($destinationPath)) {
                mkdir($destinationPath, 0777, true);
            }

            $file->move($destinationPath, $fileName);

            $imagepath = '/projectimages/lensmanegment/scratch_coating/' . $fileName;
        }

        $data = ScracthCoating::create([
            'title' => $request->title,
            'sub_title' => $request->sub_title,
            'image_url' => $imagepath ?? null,
            'price' => $request->price,
            'description' => $request->description,
        ]);

        return response()->json([
            'status' => true,
            'message' => 'Scratch coating created successfully',
            'data' => $data,
        ]);
    }


    public function updateScratchCoating(Request $request, $id)
    {
        $validator = Validator::make($request->all(), [
            'title' => 'required|string|max:255',
            'sub_title' => 'required|string|max:255',
            'image' => 'nullable|file',
            'price' => 'required|numeric|min:0',
            'description' => 'required|string',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => false,
                'errors' => $validator->errors(),
            ], 422);
        }

        $coating = ScracthCoating::find($id);

        if (!$coating) {
            return response()->json([
                'status' => false,
                'message' => 'Scratch coating not found',
            ], 404);
        }

        $imagepath = $coating->image_url; // keep existing image by default

        if ($request->hasFile('image')) {
            $file = $request->file('image');
            $originalName = $file->getClientOriginalName();
            $fileName = time() . '_' . preg_replace('/\s+/', '_', $originalName);
            $destinationPath = public_path('projectimages/lensmanegment/scratch_coating');
            if (!file_exists($destinationPath)) {
                mkdir($destinationPath, 0777, true);
            }

            $file->move($destinationPath, $fileName);
            $imagepath = '/projectimages/lensmanegment/scratch_coating/' . $fileName;

            // Delete old image if it exists
            $oldImagePath = public_path($coating->image_url);
            if (file_exists($oldImagePath)) {
                unlink($oldImagePath);
            }
        }

        $coating->update([
            'title' => $request->title,
            'sub_title' => $request->sub_title,
            'image_url' => $imagepath,
            'price' => $request->price,
            'description' => $request->description,
        ]);

        return response()->json([
            'status' => true,
            'message' => 'Scratch coating updated successfully',
            'data' => $coating,
        ]);
    }


    public function deleteScratchCoating($id)
    {
        $coating = ScracthCoating::find($id);

        if (!$coating) {
            return response()->json([
                'status' => false,
                'message' => 'Scratch coating not found',
            ], 404);
        }

        $imagePath = public_path($coating->image_url);
        if (file_exists($imagePath)) {
            unlink($imagePath);
        }

        $coating->delete();

        return response()->json([
            'status' => true,
            'message' => 'Scratch coating deleted successfully',
        ]);
    }


    //lense tint

    public function getLensTint($id = null)
    {
        $baseUrl = env('LOGO_URL');

        if ($id) {
            $tint = LensTint::find($id);

            if (!$tint) {
                return response()->json([
                    'status' => false,
                    'message' => 'Lens tint not found',
                ], 404);
            }

            $tint->image_url = $baseUrl . $tint->image_url;

            return response()->json([
                'status' => true,
                'data' => $tint,
            ]);
        }

        $tints = LensTint::all();

        foreach ($tints as $tint) {
            $tint->image_url = $baseUrl . $tint->image_url;
        }

        return response()->json([
            'status' => true,
            'data' => $tints,
        ]);
    }


    public function createLensTint(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'title' => 'required|string|max:255',
            'sub_title' => 'required|string|max:255',
            'image' => 'required|file',
            'price' => 'required|numeric|min:0',
            'description' => 'required|string',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => false,
                'errors' => $validator->errors(),
            ], 422);
        }

        if ($request->hasFile('image')) {
            $file = $request->file('image');
            $originalName = $file->getClientOriginalName();
            $fileName = time() . '_' . preg_replace('/\s+/', '_', $originalName);
            $destinationPath = public_path('projectimages/lensmanegment/lens_tint');

            if (!file_exists($destinationPath)) {
                mkdir($destinationPath, 0777, true);
            }

            $file->move($destinationPath, $fileName);
            $imagepath = '/projectimages/lensmanegment/lens_tint/' . $fileName;
        }

        $data = LensTint::create([
            'title' => $request->title,
            'sub_title' => $request->sub_title,
            'image_url' => $imagepath ?? null,
            'price' => $request->price,
            'description' => $request->description,
        ]);

        return response()->json([
            'status' => true,
            'message' => 'Lens tint created successfully',
            'data' => $data,
        ]);
    }

    public function updateLensTint(Request $request, $id)
    {
        $validator = Validator::make($request->all(), [
            'title' => 'required|string|max:255',
            'sub_title' => 'required|string|max:255',
            'image' => 'nullable|file',
            'price' => 'required|numeric|min:0',
            'description' => 'required|string',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => false,
                'errors' => $validator->errors(),
            ], 422);
        }

        $tint = LensTint::find($id);

        if (!$tint) {
            return response()->json([
                'status' => false,
                'message' => 'Lens tint not found',
            ], 404);
        }

        $imagepath = $tint->image_url; // Keep existing image if no new image is uploaded

        if ($request->hasFile('image')) {
            $file = $request->file('image');
            $originalName = $file->getClientOriginalName();
            $fileName = time() . '_' . preg_replace('/\s+/', '_', $originalName);
            $destinationPath = public_path('projectimages/lensmanegment/lens_tint');
            if (!file_exists($destinationPath)) {
                mkdir($destinationPath, 0777, true);
            }

            $file->move($destinationPath, $fileName);
            $imagepath = '/projectimages/lensmanegment/lens_tint/' . $fileName;

            // Delete old image if exists
            $oldImagePath = public_path($tint->image_url);
            if (file_exists($oldImagePath)) {
                unlink($oldImagePath);
            }
        }

        $tint->update([
            'title' => $request->title,
            'sub_title' => $request->sub_title,
            'image_url' => $imagepath,
            'price' => $request->price,
            'description' => $request->description,
        ]);

        return response()->json([
            'status' => true,
            'message' => 'Lens tint updated successfully',
            'data' => $tint,
        ]);
    }

    public function deleteLensTint($id)
    {
        $tint = LensTint::find($id);

        if (!$tint) {
            return response()->json([
                'status' => false,
                'message' => 'Lens tint not found',
            ], 404);
        }

        $imagePath = public_path($tint->image_url);
        if (file_exists($imagePath)) {
            unlink($imagePath);
        }

        $tint->delete();

        return response()->json([
            'status' => true,
            'message' => 'Lens tint deleted successfully',
        ]);
    }

    //lense prodection work
    public function getLensProtection($id = null)
    {
        $baseUrl = env('LOGO_URL');

        if ($id) {
            $protection = LensProtection::find($id);

            if (!$protection) {
                return response()->json([
                    'status' => false,
                    'message' => 'Lens protection not found',
                ], 404);
            }

            $protection->image_url = $protection->image_url ? $baseUrl . $protection->image_url : null;

            return response()->json([
                'status' => true,
                'data' => $protection,
            ]);
        }

        $protections = LensProtection::all();

        foreach ($protections as $protection) {
            $protection->image_url = $protection->image_url ? $baseUrl . $protection->image_url : null;
        }

        return response()->json([
            'status' => true,
            'data' => $protections,
        ]);
    }


    public function createLensProtection(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'title' => 'required|string|max:255',
            'sub_title' => 'required|string|max:255',
            'image' => 'required|file',
            'price' => 'required|numeric|min:0',
            'description' => 'required|string',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => false,
                'errors' => $validator->errors(),
            ], 422);
        }

        if ($request->hasFile('image')) {
            $file = $request->file('image');
            $originalName = $file->getClientOriginalName();
            $fileName = time() . '_' . preg_replace('/\s+/', '_', $originalName);
            $destinationPath = public_path('projectimages/lensmanegment/lens_protection');

            if (!file_exists($destinationPath)) {
                mkdir($destinationPath, 0777, true);
            }

            $file->move($destinationPath, $fileName);
            $imagepath = '/projectimages/lensmanegment/lens_protection/' . $fileName;
        }

        $data = LensProtection::create([
            'title' => $request->title,
            'sub_title' => $request->sub_title,
            'image_url' => $imagepath ?? null,
            'price' => $request->price,
            'description' => $request->description,
        ]);

        return response()->json([
            'status' => true,
            'message' => 'Lens protection created successfully',
            'data' => $data,
        ]);
    }

    public function updateLensProtection(Request $request, $id)
    {
        $validator = Validator::make($request->all(), [
            'title' => 'required|string|max:255',
            'sub_title' => 'required|string|max:255',
            'image' => 'nullable|file',
            'price' => 'required|numeric|min:0',
            'description' => 'required|string',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => false,
                'errors' => $validator->errors(),
            ], 422);
        }

        $protection = LensProtection::find($id);

        if (!$protection) {
            return response()->json([
                'status' => false,
                'message' => 'Lens protection not found',
            ], 404);
        }

        $imagepath = $protection->image_url; // Keep existing image if no new image is uploaded

        if ($request->hasFile('image')) {
            $file = $request->file('image');
            $originalName = $file->getClientOriginalName();
            $fileName = time() . '_' . preg_replace('/\s+/', '_', $originalName);
            $destinationPath = public_path('projectimages/lensmanegment/lens_protection');
            if (!file_exists($destinationPath)) {
                mkdir($destinationPath, 0777, true);
            }

            $file->move($destinationPath, $fileName);
            $imagepath = '/projectimages/lensmanegment/lens_protection/' . $fileName;

            // Delete old image if exists
            $oldImagePath = public_path($protection->image_url);
            if (file_exists($oldImagePath)) {
                unlink($oldImagePath);
            }
        }

        $protection->update([
            'title' => $request->title,
            'sub_title' => $request->sub_title,
            'image_url' => $imagepath,
            'price' => $request->price,
            'description' => $request->description,
        ]);

        return response()->json([
            'status' => true,
            'message' => 'Lens protection updated successfully',
            'data' => $protection,
        ]);
    }

    public function deleteLensProtection($id)
    {
        $protection = LensProtection::find($id);

        if (!$protection) {
            return response()->json([
                'status' => false,
                'message' => 'Lens protection not found',
            ], 404);
        }

        $imagePath = public_path($protection->image_url);
        if (file_exists($imagePath)) {
            unlink($imagePath);
        }

        $protection->delete();

        return response()->json([
            'status' => true,
            'message' => 'Lens protection deleted successfully',
        ]);
    }


    public function getBlueLightProtection($id = null)
    {
        $baseUrl = env('LOGO_URL');

        if ($id) {
            $protection = BlueLightProtection::find($id);

            if (!$protection) {
                return response()->json([
                    'status' => false,
                    'message' => 'Blue light protection not found',
                ], 404);
            }

            $protection->image_url = $protection->image_url ? $baseUrl . $protection->image_url : null;

            return response()->json([
                'status' => true,
                'data' => $protection,
            ]);
        }

        $protections = BlueLightProtection::all();

        foreach ($protections as $protection) {
            $protection->image_url = $protection->image_url ? $baseUrl . $protection->image_url : null;
        }

        return response()->json([
            'status' => true,
            'data' => $protections,
        ]);
    }



    public function createBlueLightProtection(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'title' => 'required|string|max:255',
            'sub_title' => 'required|string|max:255',
            'image' => 'required|file',
            'price' => 'required|numeric|min:0',
            'description' => 'required|string',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => false,
                'errors' => $validator->errors(),
            ], 422);
        }

        if ($request->hasFile('image')) {
            $file = $request->file('image');
            $originalName = $file->getClientOriginalName();
            $fileName = time() . '_' . preg_replace('/\s+/', '_', $originalName);
            $destinationPath = public_path('projectimages/lensmanegment/blue_light_protection');

            if (!file_exists($destinationPath)) {
                mkdir($destinationPath, 0777, true);
            }

            $file->move($destinationPath, $fileName);
            $imagepath = '/projectimages/lensmanegment/blue_light_protection/' . $fileName;
        }

        $data = BlueLightProtection::create([
            'title' => $request->title,
            'sub_title' => $request->sub_title,
            'image_url' => $imagepath ?? null,
            'price' => $request->price,
            'description' => $request->description,
        ]);

        return response()->json([
            'status' => true,
            'message' => 'Blue light protection created successfully',
            'data' => $data,
        ]);
    }

    public function updateBlueLightProtection(Request $request, $id)
    {
        $validator = Validator::make($request->all(), [
            'title' => 'required|string|max:255',
            'sub_title' => 'required|string|max:255',
            'image' => 'nullable|file',
            'price' => 'required|numeric|min:0',
            'description' => 'required|string',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => false,
                'errors' => $validator->errors(),
            ], 422);
        }

        $protection = BlueLightProtection::find($id);

        if (!$protection) {
            return response()->json([
                'status' => false,
                'message' => 'Blue light protection not found',
            ], 404);
        }

        $imagepath = $protection->image_url; // Keep existing image if no new image is uploaded

        if ($request->hasFile('image')) {
            $file = $request->file('image');
            $originalName = $file->getClientOriginalName();
            $fileName = time() . '_' . preg_replace('/\s+/', '_', $originalName);
            $destinationPath = public_path('projectimages/lensmanegment/blue_light_protection');
            if (!file_exists($destinationPath)) {
                mkdir($destinationPath, 0777, true);
            }

            $file->move($destinationPath, $fileName);
            $imagepath = '/projectimages/lensmanegment/blue_light_protection/' . $fileName;

            // Delete old image if exists
            $oldImagePath = public_path($protection->image_url);
            if (file_exists($oldImagePath)) {
                unlink($oldImagePath);
            }
        }

        $protection->update([
            'title' => $request->title,
            'sub_title' => $request->sub_title,
            'image_url' => $imagepath,
            'price' => $request->price,
            'description' => $request->description,
        ]);

        return response()->json([
            'status' => true,
            'message' => 'Blue light protection updated successfully',
            'data' => $protection,
        ]);
    }

    public function deleteBlueLightProtection($id)
    {
        $protection = BlueLightProtection::find($id);

        if (!$protection) {
            return response()->json([
                'status' => false,
                'message' => 'Blue light protection not found',
            ], 404);
        }

        $imagePath = public_path($protection->image_url);
        if (file_exists($imagePath)) {
            unlink($imagePath);
        }

        $protection->delete();

        return response()->json([
            'status' => true,
            'message' => 'Blue light protection deleted successfully',
        ]);
    }


    public function getall()
    {

        $CompanyId = auth('sanctum')->user()->company_id;
        $baseUrl = env('LOGO_URL');

        $materials = LensMaterial::all()->map(function ($item) use ($baseUrl) {
            $item->image_url = $baseUrl . $item->image_url;
            return $item;
        });

        $coatings = ScracthCoating::all()->map(function ($item) use ($baseUrl) {
            $item->image_url = $baseUrl . $item->image_url;
            return $item;
        });

        $tints = LensTint::all()->map(function ($item) use ($baseUrl) {
            $item->image_url = $baseUrl . $item->image_url;
            return $item;
        });

        $lensProtections = LensProtection::all()->map(function ($item) use ($baseUrl) {
            $item->image_url = $baseUrl . $item->image_url;
            return $item;
        });

        $blueLightProtections = BlueLightProtection::all()->map(function ($item) use ($baseUrl) {
            $item->image_url = $baseUrl . $item->image_url;
            return $item;
        });




        return response()->json([
            'materials' => $materials,
            'coatings' => $coatings,
            'tints' => $tints,
            'lens_protections' => $lensProtections,
            'blue_light_protections' => $blueLightProtections,
        ]);
    }

    // public function getall()
    // {
    //     $CompanyId = auth('sanctum')->user()->company_id;
    //     $baseUrl = env('LOGO_URL');

    //     // Only get materials assigned to this company
    //     $materials = LensMaterial::whereIn('id', function ($query) use ($CompanyId) {
    //         $query->select('lens_material_id')
    //             ->from('company_lens_material_mapper')
    //             ->where('company_id', $CompanyId);
    //     })->get()->map(function ($item) use ($baseUrl) {
    //         $item->image_url = $baseUrl . $item->image_url;
    //         return $item;
    //     });

    //     // Only get scratch coatings assigned to this company
    //     $coatings = ScracthCoating::whereIn('id', function ($query) use ($CompanyId) {
    //         $query->select('scratch_coating_id')
    //             ->from('company_scratch_coating_mapper')
    //             ->where('company_id', $CompanyId);
    //     })->get()->map(function ($item) use ($baseUrl) {
    //         $item->image_url = $baseUrl . $item->image_url;
    //         return $item;
    //     });

    //     // Only get tints assigned to this company
    //     $tints = LensTint::whereIn('id', function ($query) use ($CompanyId) {
    //         $query->select('lens_tint_id')
    //             ->from('company_lens_tint_mapper')
    //             ->where('company_id', $CompanyId);
    //     })->get()->map(function ($item) use ($baseUrl) {
    //         $item->image_url = $baseUrl . $item->image_url;
    //         return $item;
    //     });

    //     // Only get lens protections assigned to this company
    //     $lensProtections = LensProtection::whereIn('id', function ($query) use ($CompanyId) {
    //         $query->select('lens_protection_id')
    //             ->from('company_lens_protection_mapper')
    //             ->where('company_id', $CompanyId);
    //     })->get()->map(function ($item) use ($baseUrl) {
    //         $item->image_url = $baseUrl . $item->image_url;
    //         return $item;
    //     });

    //     // Only get blue light protections assigned to this company
    //     $blueLightProtections = BlueLightProtection::whereIn('id', function ($query) use ($CompanyId) {
    //         $query->select('blue_light_protection_id')
    //             ->from('company_blue_light_protection_mapper')
    //             ->where('company_id', $CompanyId);
    //     })->get()->map(function ($item) use ($baseUrl) {
    //         $item->image_url = $baseUrl . $item->image_url;
    //         return $item;
    //     });

    //     return response()->json([
    //         'materials' => $materials,
    //         'coatings' => $coatings,
    //         'tints' => $tints,
    //         'lens_protections' => $lensProtections,
    //         'blue_light_protections' => $blueLightProtections,
    //     ]);
    // }
}
