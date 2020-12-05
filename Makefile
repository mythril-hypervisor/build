.DEFAULT_GOAL := test-images

OUTPUT_ROOT=output/
TEST_GUEST_KERNEL_TARGET=$(OUTPUT_ROOT)/test-bzImage
TEST_GUEST_KERNEL_INITRAMFS=$(OUTPUT_ROOT)/test-initramfs.img

.PHONY: test-images
test-images: $(TEST_GUEST_KERNEL_TARGET) $(TEST_GUEST_KERNEL_INITRAMFS)

$(OUTPUT_ROOT):
	mkdir -p $(OUTPUT_ROOT)

$(TEST_GUEST_KERNEL_TARGET): buildroot.config kernel.config $(OUTPUT_ROOT)
	cp buildroot.config buildroot/.config
	make -C buildroot linux
	cp buildroot/output/images/bzImage $(TEST_GUEST_KERNEL_TARGET)

$(TEST_GUEST_KERNEL_INITRAMFS): $(TEST_GUEST_KERNEL_TARGET)
	cp buildroot.config buildroot/.config
	make -C buildroot
	cp buildroot/output/images/rootfs.cpio.gz $(TEST_GUEST_KERNEL_INITRAMFS)

.PHONY: docker
docker:
	docker build .

.PHONY: clean
clean:
	rm -rf $(OUTPUT_ROOT)
	make -C buildroot clean
