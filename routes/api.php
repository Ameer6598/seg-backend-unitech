<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\AdminController;
use App\Http\Controllers\OrderController;
use App\Http\Controllers\StripeController;
use App\Http\Controllers\CompanyController;
use App\Http\Controllers\ProductController;
use App\Http\Controllers\EmployeeController;
use App\Http\Controllers\LenseTypeController;
use App\Http\Controllers\TempOrderController;
use App\Http\Controllers\ImpersonationController;
use App\Http\Controllers\LensManegment\AssignLenstint;
use App\Http\Controllers\LensTypeSubcategoriesController;
use App\Http\Controllers\LensManegment\AssignLensMaterial;
use App\Http\Controllers\LensManegment\AssignLensProtection;
use App\Http\Controllers\LensManegment\AssignScratchCoating;
use App\Http\Controllers\LensManegment\lensManegmentController;
use App\Http\Controllers\LensManegment\AssignBlueLightProtection;

Route::get('/users', function () {
    return 'API User route done' . Hash::make('admin');
});


Route::post('/login', [AuthController::class, 'login']);

Route::get('/loginerorr', [AuthController::class, 'loginerror'])->name('login');

Route::post('set/newpassword', [AuthController::class, 'set']);

Route::post('forget/password', [AuthController::class, 'forgetpassword']);

Route::post('/create-checkout-session', [StripeController::class, 'createCheckoutSession']);
Route::post('/check-payment-status', [StripeController::class, 'checkPaymentStatus']);

Route::get('/pay-later-orders', [OrderController::class, 'getPayLaterOrders']);
Route::get('get/company/list', [OrderController::class, 'companylist']);


Route::get('company/assigned-lens-subcategories', [LensTypeSubcategoriesController::class, 'getAssignedLensTypeSubcategoriesForCompany']);



Route::middleware('auth:sanctum')->group(function () {

    Route::get('/user', function (Request $request) {
        return $request->user();
    });
    Route::get('leave-impersonate', [ImpersonationController::class, 'leaveImpersonation']);

    Route::middleware('role:owner,company')->group(function () {
        Route::post('impersonate/employe/{id}', [ImpersonationController::class, 'impersonateemployee']);
    });


    Route::post('logout', [AuthController::class, 'logout'])->name('logout.current');
    Route::post('logout/all', [AuthController::class, 'logoutAll'])->name('logout.all');
    Route::post('check-validation', [AuthController::class, 'validateToken']);


    Route::middleware('role:owner')->group(function () {


        Route::post('impersonate/company/{id}', [ImpersonationController::class, 'impersonatecompany']);


        Route::post('update-owner-details', [AdminController::class, 'updateOwnerDetails']);
        Route::prefix('company')->group(function () {
            Route::get('companies', [CompanyController::class, 'getAll']);



            Route::post('create', [CompanyController::class, 'create']); // Keep "create" if you want
            Route::post('{companyId}', [CompanyController::class, 'update']);
            Route::delete('{companyId}', [CompanyController::class, 'delete']);
            Route::get('{companyId}', [CompanyController::class, 'getCompany']);
        });

        //assign to companies
        Route::post('assign-product-to-company', [CompanyController::class, 'assignProductToCompany']);
        Route::post('assign-lens_material_to_company', [AssignLensMaterial::class, 'AssignLensMaterialToCompany']);
        Route::post('assign-scratch_coating-to-company', [AssignScratchCoating::class, 'assignScratchCoatingToCompany']);
        Route::post('assign-lens_tint-to-company', [AssignLenstint::class, 'assignLensTintToCompany']);
        Route::post('assign-lens_protection-to-company', [AssignLensProtection::class, 'assignLensProtectionToCompany']);
        Route::post('assign-blue_light_protection-to-company', [AssignBlueLightProtection::class, 'assignBlueLightProtectionToCompany']);
        Route::post('assign-company_lens_type_subcategories-to-company', [LensTypeSubcategoriesController::class, 'assignLensTypeSubcategoriesToCompanies']);



        //Lens Types Categories curd
        Route::post('create-lense-type-categories', [LenseTypeController::class, 'create']);
        Route::get('lense-type-categories', [LenseTypeController::class, 'get']);
        Route::post('update-lense-type-categories/{id}', [LenseTypeController::class, 'update']);
        Route::delete('lense-type-categories/{id}', [LenseTypeController::class, 'delete']);


        Route::post('create-lense-type-sub-categories', [LensTypeSubcategoriesController::class, 'create']);
        Route::get('lense-type-sub-categories', [LensTypeSubcategoriesController::class, 'get']);
        Route::post('update-lense-type-sub-categories/{id}', [LensTypeSubcategoriesController::class, 'update']);
        Route::delete('lense-type-sub-categories/{id}', [LensTypeSubcategoriesController::class, 'delete']);






        Route::prefix('product')->group(function () {
            Route::post('create', [ProductController::class, 'create']);
            Route::get('all', [ProductController::class, 'getProductOrAll']);
            Route::get('{productId}', [ProductController::class, 'getProductOrAll']);
            Route::get('/details/{productId}', [ProductController::class, 'getFullProductDetail']);
            Route::post('update/{id}', [ProductController::class, 'update']);
            Route::delete('delete/{productId}', [ProductController::class, 'deleteProduct']);
            Route::post('/upload-products', [ProductController::class, 'upload'])->name('products.upload');
        });


        Route::get('get-all-orders', [OrderController::class, 'getAllOrders']);
        Route::post('update-order/{id}', [OrderController::class, 'updateOrder']);
        Route::post('update-order-tray/{id}', [OrderController::class, 'update_tray_id']);
        Route::post('update-order-status', [OrderController::class, 'updateOrderStatus']);
        Route::get('employees', [EmployeeController::class, 'getAll']);
    });
    Route::middleware('role:company')->group(function () {

        Route::get('getMyCompanyDetails', [CompanyController::class, 'getMyCompanyDetails']);
        Route::prefix('employee/')->group(function () {
            Route::post('import', [EmployeeController::class, 'import']);
            Route::get('export', [EmployeeController::class, 'downloadSample']);
            Route::get('employees', [EmployeeController::class, 'getAll']);
            Route::post('create', [EmployeeController::class, 'create']);
            Route::post('assign-product', [EmployeeController::class, 'assignProduct']);
            // Route::post('update',[EmployeeController::class,'update']);
            Route::post('update-benefit-amount', [EmployeeController::class, 'bulkUpdate']);
            Route::delete('{employeeId}', [EmployeeController::class, 'delete']);
            Route::get('{employeeId}', [EmployeeController::class, 'getEmployee']);
        });
        Route::get('get-company-products', [ProductController::class, 'getCompanyProducts']);
        Route::get('get-company-orders', [OrderController::class, 'getCompanyOrders']);
        //company itself changing his details
        Route::post('change-company-password', [CompanyController::class, 'companypassword']);
        Route::post('update-company', [CompanyController::class, 'updatedetails']);
    });
    Route::middleware('role:company,owner')->group(function () {
        Route::post('employee/update', [EmployeeController::class, 'update']);
    });
    Route::delete('{employeeId}', [EmployeeController::class, 'delete']);
    Route::middleware('role:employee')->group(function () {
        Route::get('get-employee-products', [ProductController::class, 'getemployeeProducts']);
        Route::get('get-product-manufactures', [ProductController::class, 'getManufacturers']);



        // Route::post('create-order', [OrderController::class, 'storeOrder']);
        Route::post('order/with-new-prescription', [OrderController::class, 'newPresOrder']);
        Route::post('order/with-existing-prescription', [OrderController::class, 'existingPresOrder']);

        Route::get('get-employee-orders', [OrderController::class, 'getEmployeeOrders']);
        Route::get('lens-management/all', [lensManegmentController::class, 'getall']);
        Route::post('change-employe-password', [EmployeeController::class, 'employepassword']);
        Route::post('update-employee', [EmployeeController::class, 'updatedetails']);
        //route for tem order
        Route::post('orders/temp-store', [TempOrderController::class, 'saveOrderDetails']);
        Route::get('employee/temp/order-details', [TempOrderController::class, 'getEmployeeOrderDetails']);
    });


    Route::middleware('role:owner,company')->group(function () {
        // Categories
        Route::post('/categories', [ProductController::class, 'createCategory']);
        Route::get('/categories', [ProductController::class, 'getCategories']);
        Route::post('/categorie-update', [ProductController::class, 'updateCategory']);
        Route::delete('/categories/{id}', [ProductController::class, 'deleteCategory']);

        // Subcategory Routes
        Route::post('/subcategories', [ProductController::class, 'createSubcategory']);
        Route::get('/subcategories', [ProductController::class, 'getSubcategories']);
        Route::post('/subcategory-update', [ProductController::class, 'updateSubcategory']);
        Route::delete('/subcategories/{id}', [ProductController::class, 'deleteSubcategory']);




        // Colors
        Route::post('/colors', [ProductController::class, 'createColor']);
        Route::get('/colors', [ProductController::class, 'getColors']);
        Route::post('/color-update', [ProductController::class, 'updateColor']);
        Route::delete('/colors/{id}', [ProductController::class, 'deleteColor']);

        // Frame Sizes
        Route::post('/framesizes', [ProductController::class, 'createFrameSize']);
        Route::get('/framesizes', [ProductController::class, 'getFrameSizes']);
        Route::post('/framesize-update', [ProductController::class, 'updateFrameSize']);
        Route::delete('/framesizes/{id}', [ProductController::class, 'deleteFrameSize']);

        // Rim Types
        Route::post('/rimtypes', [ProductController::class, 'createRimType']);
        Route::get('/rimtypes', [ProductController::class, 'getRimTypes']);
        Route::post('/rimtype-update', [ProductController::class, 'updateRimType']);
        Route::delete('/rimtypes/{id}', [ProductController::class, 'deleteRimType']);

        // Styles
        Route::post('/styles', [ProductController::class, 'createStyle']);
        Route::get('/styles', [ProductController::class, 'getStyles']);
        Route::post('/style-update', [ProductController::class, 'updateStyle']);
        Route::delete('/styles/{id}', [ProductController::class, 'deleteStyle']);

        // Materials
        Route::post('/materials', [ProductController::class, 'createMaterial']);
        Route::get('/materials', [ProductController::class, 'getMaterials']);
        Route::post('/material-update', [ProductController::class, 'updateMaterial']);
        Route::delete('/materials/{id}', [ProductController::class, 'deleteMaterial']);

        // Shapes
        Route::post('/shapes', [ProductController::class, 'createShape']);
        Route::get('/shapes', [ProductController::class, 'getShapes']);
        Route::post('/shape-update', [ProductController::class, 'updateShape']);
        Route::delete('/shapes/{id}', [ProductController::class, 'deleteShape']);

        // Manufacturers
        Route::post('/manufacturers', [ProductController::class, 'createManufacturer']);
        Route::get('/manufacturers', [ProductController::class, 'getManufacturers']);
        Route::post('/manufacturer-update', [ProductController::class, 'updateManufacturer']);
        Route::delete('/manufacturers/{id}', [ProductController::class, 'deleteManufacturer']);
    });

    // routes for lense manegment
    Route::middleware('role:owner')->group(function () {
        //lense lens material
        Route::get('lens-materials', [lensManegmentController::class, 'get']); // all
        Route::get('lens-materials/{id}', [lensManegmentController::class, 'get']); // single
        Route::post('create-lens-material', [lensManegmentController::class, 'create']);
        Route::post('update-lens-material/{id}', [lensManegmentController::class, 'update']);
        Route::delete('delete/lens-materials/{id}', [lensManegmentController::class, 'delete']); // single
        // Scratch Coating Routes
        Route::get('scratch-coating', [lensManegmentController::class, 'getScratchCoating']); // all
        Route::get('scratch-coating/{id}', [lensManegmentController::class, 'getScratchCoating']); // single
        Route::post('create-scratch-coating', [lensManegmentController::class, 'createScratchCoating']);
        Route::post('update-scratch-coating/{id}', [lensManegmentController::class, 'updateScratchCoating']);
        Route::delete('delete/scratch-coating/{id}', [lensManegmentController::class, 'deleteScratchCoating']); // single
        // Lens Tint Routes
        Route::get('lens-tint', [lensManegmentController::class, 'getLensTint']); // all
        Route::get('lens-tint/{id}', [lensManegmentController::class, 'getLensTint']); // single
        Route::post('create-lens-tint', [lensManegmentController::class, 'createLensTint']);
        Route::post('update-lens-tint/{id}', [lensManegmentController::class, 'updateLensTint']);
        Route::delete('delete/lens-tint/{id}', [lensManegmentController::class, 'deleteLensTint']); // single
        // Lens Protection Routes
        Route::get('lens-protection', [lensManegmentController::class, 'getLensProtection']); // all
        Route::get('lens-protection/{id}', [lensManegmentController::class, 'getLensProtection']); // single
        Route::post('create-lens-protection', [lensManegmentController::class, 'createLensProtection']);
        Route::post('update-lens-protection/{id}', [lensManegmentController::class, 'updateLensProtection']);
        Route::delete('delete/lens-protection/{id}', [lensManegmentController::class, 'deleteLensProtection']); // single

        // Blue Light Protection Routes
        Route::get('blue-light-protection', [lensManegmentController::class, 'getBlueLightProtection']); // all
        Route::get('blue-light-protection/{id}', [lensManegmentController::class, 'getBlueLightProtection']); // single
        Route::post('create-blue-light-protection', [lensManegmentController::class, 'createBlueLightProtection']);
        Route::post('update-blue-light-protection/{id}', [lensManegmentController::class, 'updateBlueLightProtection']);
        Route::delete('delete/blue-light-protection/{id}', [lensManegmentController::class, 'deleteBlueLightProtection']); // single
    });
});
